---
name: roblox-client-server
description: Teach and generate correct Roblox client-server architecture — LocalScripts vs Scripts, replication rules, RemoteEvent and RemoteFunction patterns, ownership, FilteringEnabled reality, and how to structure secure game code. Use when the user asks about client side, server side, remotes, replication, exploit-safe code, or how to split logic between client and server.
---

# Roblox Client / Server Architecture

Roblox is a **client-server** model. Every instance lives in one of three places: Server only, Client only, or Replicated (visible to both, owned by server).

## Where code runs

| Location | Runs on | Typical class | Can touch |
|----------|---------|---------------|-----------|
| ServerScriptService / Workspace | Server | Script | Everything server-side + replicated instances |
| StarterPlayerScripts / StarterCharacterScripts | Each client | LocalScript | LocalPlayer, PlayerGui, camera, input |
| ReplicatedStorage ModuleScripts | Whoever requires them | ModuleScript | Depends on who called `require` |

Never put game-critical logic (damage, currency, inventory grants) only in a LocalScript. Exploiters own the client.

## Replication basics

- Server creates an instance under Workspace / ReplicatedStorage → all clients see it.
- Client creates an instance under its own PlayerGui / character → only that client sees it (unless parented to a replicated container, which the server will reject or ignore for ownership).
- Properties change on server → replicate to clients.
- Properties change on client for a non-owned part → usually ignored or only local.

`Workspace.FilteringEnabled` is always on in modern Roblox. There is no “FE off” escape hatch.

## RemoteEvent (fire and forget)

```lua
-- Server (Script in ServerScriptService)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = Instance.new("RemoteEvent")
remote.Name = "DoAction"
remote.Parent = ReplicatedStorage

remote.OnServerEvent:Connect(function(player, actionName, payload)
	-- ALWAYS validate player + payload
	if typeof(actionName) ~= "string" then return end
	if typeof(payload) ~= "table" then return end
	-- process...
end)

-- later, server → one client
remote:FireClient(player, "Result", { ok = true })

-- server → all clients
remote:FireAllClients("Announcement", { text = "Hello" })
```

```lua
-- Client (LocalScript)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = ReplicatedStorage:WaitForChild("DoAction")

remote:FireServer("Jump", { power = 50 })

remote.OnClientEvent:Connect(function(kind, data)
	if kind == "Result" then
		print(data.ok)
	end
end)
```

## RemoteFunction (request / response)

Use sparingly — they yield and can be abused for lag.

```lua
-- Server
local rf = Instance.new("RemoteFunction")
rf.Name = "GetStats"
rf.Parent = ReplicatedStorage

rf.OnServerInvoke = function(player)
	return { coins = 100, level = 3 } -- return only what that player may see
end
```

```lua
-- Client
local rf = ReplicatedStorage:WaitForChild("GetStats")
local stats = rf:InvokeServer()
```

Prefer RemoteEvent + client callback pattern for most gameplay.

## Ownership and physics

- Parts are owned by the server by default.
- `BasePart:SetNetworkOwner(player)` gives that client physics authority (good for vehicles, bad for competitive combat).
- Never trust client-reported positions for damage or rewards.

## Secure pattern (server authority)

1. Client sends **intent** only (`"I want to swing"`, `"I want to buy item 3"`).
2. Server validates cooldowns, distance, inventory, currency.
3. Server applies the real change (health, money, tools).
4. Server notifies clients of the result for VFX / UI.

```lua
-- BAD (client decides damage)
damageRemote:FireServer(targetPlayer, 9999)

-- GOOD (client requests action)
combatRemote:FireServer("MeleeSwing")
-- server raycasts / magnitude checks and applies damage itself
```

## Folder layout recommendation

```
ReplicatedStorage
  Remotes/          -- all RemoteEvents / RemoteFunctions
  Shared/           -- ModuleScripts safe for both sides (pure functions, configs)
ServerScriptService
  Services/         -- server-only modules (DataService, CombatService)
  Main.server.lua
StarterPlayer
  StarterPlayerScripts
    Controllers/    -- client modules (UIController, InputController)
    Main.client.lua
```

## Checklist when writing new systems

1. Who is allowed to decide the outcome? → Server.
2. What does the client need for responsive feel? → Prediction + later reconciliation.
3. Is every RemoteEvent argument type-checked and range-checked?
4. Can a spammed remote crash or lag the server? Add rate limits.
5. Are ModuleScripts in ReplicatedStorage free of server secrets (API keys, admin lists)?

## References

- Remote validation and rate limiting → see skill `roblox-networking`
- Data persistence on server → see skill `roblox-datastores`
- Combat example with server authority → see skill `roblox-combat-systems`
