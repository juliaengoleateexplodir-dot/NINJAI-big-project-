---
name: roblox-datastores
description: Teach and generate production Roblox DataStore code — GetAsync/SetAsync/UpdateAsync, session locking, retries, OrderedDataStore leaderboards, ProfileService-style patterns, and safe player data loading. Use when the user asks about saving data, DataStores, leaderstats persistence, inventories, or preventing data loss.
---

# Roblox DataStores (production patterns)

All persistence runs **on the server only**. Never call DataStoreService from a LocalScript.

## Basic API

```lua
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local store = DataStoreService:GetDataStore("PlayerData_v1")

local function load(player)
	local key = "p_" .. player.UserId
	local ok, data = pcall(function()
		return store:GetAsync(key)
	end)
	if not ok then
		warn("GetAsync failed", data)
		return nil -- caller should retry or kick
	end
	return data or { coins = 0, level = 1 }
end

local function save(player, data)
	local key = "p_" .. player.UserId
	local ok, err = pcall(function()
		store:SetAsync(key, data)
	end)
	if not ok then
		warn("SetAsync failed", err)
	end
	return ok
end
```

Prefer **UpdateAsync** when you need atomic read-modify-write:

```lua
store:UpdateAsync(key, function(old)
	old = old or { coins = 0 }
	old.coins += 10
	return old -- return nil to abort the write
end)
```

## Session locking (stop multi-server overwrites)

When a player can join two servers (studio + live, or rare race), use a lock field:

```lua
local HttpService = game:GetService("HttpService")

local function acquireSession(player)
	local key = "p_" .. player.UserId
	local sessionId = HttpService:GenerateGUID(false)
	local ok, result = pcall(function()
		return store:UpdateAsync(key, function(old)
			old = old or { coins = 0, _session = nil, _sessionTime = 0 }
			local now = os.time()
			-- steal lock if older than 30 minutes (crashed server)
			if old._session and (now - (old._sessionTime or 0)) < 1800 then
				return nil -- abort, someone else holds the lock
			end
			old._session = sessionId
			old._sessionTime = now
			return old
		end)
	end)
	if ok and result and result._session == sessionId then
		return true, result, sessionId
	end
	return false, nil, nil
end
```

Release the lock on leave / BindToClose by clearing `_session` if it still matches.

## Retry helper

```lua
local function retry(fn, attempts, delay)
	attempts = attempts or 3
	delay = delay or 1
	local lastErr
	for i = 1, attempts do
		local ok, a, b = pcall(fn)
		if ok then return true, a, b end
		lastErr = a
		task.wait(delay * i)
	end
	return false, lastErr
end
```

## Player lifecycle skeleton

```lua
local sessions = {} -- [player] = { data = {}, sessionId = "" }

Players.PlayerAdded:Connect(function(player)
	local ok, data, sessionId = acquireSession(player)
	if not ok then
		player:Kick("Your data is still loading on another server. Try again.")
		return
	end
	sessions[player] = { data = data, sessionId = sessionId }
	-- create leaderstats from data...
end)

Players.PlayerRemoving:Connect(function(player)
	local session = sessions[player]
	if not session then return end
	retry(function()
		saveWithLockRelease(player, session.data, session.sessionId)
	end)
	sessions[player] = nil
end)

game:BindToClose(function()
	for player, session in pairs(sessions) do
		pcall(function()
			saveWithLockRelease(player, session.data, session.sessionId)
		end)
	end
	task.wait(3) -- give requests time to flush
end)
```

## OrderedDataStore (leaderboards)

```lua
local ods = DataStoreService:GetOrderedDataStore("CoinsODS_v1")

-- update score
ods:SetAsync("p_" .. userId, math.floor(coins))

-- top 10
local pages = ods:GetSortedAsync(false, 10) -- false = descending
local page = pages:GetCurrentPage()
for rank, entry in ipairs(page) do
	print(rank, entry.key, entry.value)
end
```

## Rules of thumb

1. Version your store name (`PlayerData_v1` → `v2` when schema breaks).
2. Never store Instances — only primitives / tables of primitives.
3. Cap table size; huge inventories need paging or separate keys.
4. Autosave every 60–120 s as backup to PlayerRemoving.
5. Studio and live use different DataStores unless you enable Studio API access.
6. For serious games consider ProfileService or DocumentService patterns (same ideas as above, battle-tested).

## References

- Client must never write currency → `roblox-client-server`
- Validating purchases before saving → `roblox-networking`
