---
name: roblox-networking
description: Teach secure Roblox networking — RemoteEvent validation, rate limiting, argument sanitization, anti-spam, and client prediction patterns. Use when the user asks about remotes security, exploits, rate limits, validating FireServer arguments, or lag compensation basics.
---

# Secure Roblox Networking

Every `OnServerEvent` is a public API surface that exploiters can call with any arguments at any rate.

## Validate everything

```lua
remote.OnServerEvent:Connect(function(player, action, payload)
	if typeof(action) ~= "string" then return end
	if typeof(payload) ~= "table" then return end

	if action == "Buy" then
		local itemId = payload.itemId
		if typeof(itemId) ~= "string" then return end
		if not ShopConfig[itemId] then return end
		-- continue with server-side price check
	elseif action == "DeployUnit" then
		local x, z = payload.x, payload.z
		if typeof(x) ~= "number" or typeof(z) ~= "number" then return end
		if math.abs(x) > 512 or math.abs(z) > 512 then return end
		-- snap to grid, check ownership of plot, etc.
	else
		return -- unknown action
	end
end)
```

Never trust: damage amounts, currency deltas, inventory contents, “I hit player X for Y damage”.

## Rate limiting (per player per remote)

```lua
local rate = {} -- [player] = { count = 0, reset = 0 }

local LIMIT = 10
local WINDOW = 1 -- seconds

local function allow(player)
	local now = os.clock()
	local r = rate[player]
	if not r or now > r.reset then
		rate[player] = { count = 1, reset = now + WINDOW }
		return true
	end
	if r.count >= LIMIT then
		return false
	end
	r.count += 1
	return true
end

Players.PlayerRemoving:Connect(function(p) rate[p] = nil end)

remote.OnServerEvent:Connect(function(player, ...)
	if not allow(player) then return end
	-- handle
end)
```

Tune limits per action (chat lower, movement higher).

## Sanitize strings

```lua
local function sanitizeName(str, maxLen)
	if typeof(str) ~= "string" then return nil end
	str = string.sub(str, 1, maxLen or 32)
	str = string.gsub(str, "[^%w%s%-_]", "")
	if #str == 0 then return nil end
	return str
end
```

## Distance / magnitude checks

For interactions with world objects:

```lua
local function isNear(player, position, maxDist)
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return false end
	return (hrp.Position - position).Magnitude <= maxDist
end
```

Use server-side positions, not client-sent ones.

## Client prediction (responsive feel)

1. Client plays animation / UI immediately.
2. Client sends intent to server.
3. Server accepts or rejects.
4. If rejected, client rolls back (cancel anim, restore ammo count).

```lua
-- Client
local function trySwing()
	if tick() < nextSwing then return end
	nextSwing = tick() + cooldown
	playSwingAnim()
	remote:FireServer("Swing")
end

remote.OnClientEvent:Connect(function(ev, data)
	if ev == "SwingRejected" then
		cancelSwingAnim()
		nextSwing = 0
	end
end)
```

## Unreliable remote for high-frequency data

`UnreliableRemoteEvent` for mouse position, light vehicle state — order and delivery not guaranteed, lower overhead. Still validate on server; never use for money or kills.

## BindableEvent vs RemoteEvent

- Same machine (server modules talking) → BindableEvent or shared Signal.
- Across network → RemoteEvent only.

## Checklist

1. Type-check every argument.
2. Range-check numbers and string lengths.
3. Rate-limit per player.
4. Authority for rewards / damage stays on server.
5. Prefer intent messages over full state dumps from client.
6. Log or metric suspicious spam (optional).

## References

- Overall client-server split → `roblox-client-server`
- Combat application of these rules → `roblox-combat-systems`
