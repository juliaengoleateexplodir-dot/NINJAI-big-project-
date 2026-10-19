---
name: roblox-modules-architecture
description: Teach Roblox ModuleScript architecture — service pattern, single entry points, shared vs server vs client modules, dependency order, and how to structure scalable game codebases. Use when the user asks about ModuleScripts, frameworks, Knit-like structure, organization, or clean architecture in Roblox.
---

# Roblox ModuleScript Architecture

Avoid one giant Script. Split into modules with clear ownership.

## Three kinds of modules

| Folder | Who requires | May contain |
|--------|--------------|-------------|
| ReplicatedStorage/Shared | Client + Server | Pure functions, configs, enums, signal utilities |
| ServerScriptService/Services | Server only | DataStore, combat resolution, admin |
| StarterPlayerScripts/Controllers | Client only | UI, camera, input, local VFX |

If a module touches DataStores or ServerStorage, it must **not** live in ReplicatedStorage.

## Service pattern (server)

```lua
-- ServerScriptService/Services/CoinService.lua
local CoinService = {}

local playersData -- injected or required

function CoinService.Init(deps)
	playersData = deps.PlayerDataService
end

function CoinService.Add(player, amount)
	assert(amount >= 0, "amount must be >= 0")
	local data = playersData.Get(player)
	data.coins += amount
	-- fire client UI update via RemoteEvent
end

function CoinService.Get(player)
	return playersData.Get(player).coins
end

return CoinService
```

## Controller pattern (client)

```lua
-- StarterPlayerScripts/Controllers/UIController.lua
local UIController = {}

function UIController.Init(deps)
	local remotes = deps.Remotes
	remotes.CoinsChanged.OnClientEvent:Connect(function(value)
		-- update TextLabel
	end)
end

return UIController
```

## Single bootstrap

```lua
-- ServerScriptService/Main.server.lua
local Services = script.Parent.Services

local PlayerDataService = require(Services.PlayerDataService)
local CoinService = require(Services.CoinService)
local CombatService = require(Services.CombatService)

PlayerDataService.Init({})
CoinService.Init({ PlayerDataService = PlayerDataService })
CombatService.Init({ PlayerDataService = PlayerDataService, CoinService = CoinService })

PlayerDataService.Start() -- connect PlayerAdded etc.
```

```lua
-- StarterPlayerScripts/Main.client.lua
local Controllers = script.Parent.Controllers
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Shared.Remotes) -- table of WaitForChild'd remotes

local UIController = require(Controllers.UIController)
local InputController = require(Controllers.InputController)

UIController.Init({ Remotes = Remotes })
InputController.Init({ Remotes = Remotes })
```

## Shared remotes module

```lua
-- ReplicatedStorage/Shared/Remotes.lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local folder = ReplicatedStorage:WaitForChild("Remotes")

return {
	DoAction = folder:WaitForChild("DoAction"),
	CoinsChanged = folder:WaitForChild("CoinsChanged"),
}
```

Create the actual RemoteEvent instances once on the server at boot (or in Studio as instances).

## Config modules

```lua
-- ReplicatedStorage/Shared/Config/Weapons.lua
return {
	Sword = { damage = 25, cooldown = 0.6, range = 8 },
	Bow = { damage = 15, cooldown = 0.9, range = 80 },
}
```

Both sides read the same numbers; only the server enforces them.

## Signals between modules (same side)

Prefer a tiny signal implementation or BindableEvent for server↔server / client↔client so you do not overuse Remotes.

```lua
-- Shared/Signal.lua (pure Lua)
local Signal = {}
Signal.__index = Signal
function Signal.new()
	return setmetatable({ _handlers = {} }, Signal)
end
function Signal:Connect(fn)
	table.insert(self._handlers, fn)
	return { Disconnect = function()
		local i = table.find(self._handlers, fn)
		if i then table.remove(self._handlers, i) end
	end }
end
function Signal:Fire(...)
	for _, fn in ipairs(self._handlers) do
		task.spawn(fn, ...)
	end
end
return Signal
```

## Rules

1. `require` is cached — module runs once per side.
2. Avoid cyclic requires; use late Init(deps) if needed.
3. No yield at the top level of a ModuleScript that other modules require during bootstrap (or be careful with order).
4. Keep Shared free of secrets and server-only services.
5. Name files `SomethingService.lua` / `SomethingController.lua` so intent is obvious.

## References

- What belongs on server vs client → `roblox-client-server`
- DataService internals → `roblox-datastores`
