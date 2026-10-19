---
name: roblox-combat-systems
description: Teach server-authoritative Roblox combat — hit detection, damage application, cooldowns, weapons config, replication of VFX, and anti-exploit patterns. Use when the user asks about combat systems, swords, guns, damage, hitboxes, or PvP code.
---

# Server-Authoritative Combat

Clients send **intents**. Server decides hits and damage.

## Config (Shared)

```lua
-- ReplicatedStorage/Shared/Config/Weapons.lua
return {
	Sword = {
		damage = 25,
		cooldown = 0.55,
		range = 8,
		arcHalfAngle = 70, -- degrees
		animationId = "rbxassetid://...",
	},
}
```

## Client (intent only)

```lua
-- LocalScript / Controller
local remote = Remotes.Combat
local Weapons = require(Shared.Config.Weapons)

local nextSwing = 0

local function swing()
	local now = os.clock()
	if now < nextSwing then return end
	local cfg = Weapons.Sword
	nextSwing = now + cfg.cooldown
	-- local anim + sound for responsiveness
	remote:FireServer("Swing", { weapon = "Sword" })
end

UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		swing()
	end
end)
```

## Server hit resolution

```lua
-- CombatService
local Weapons = require(Shared.Config.Weapons)

local function getHRP(player)
	local char = player.Character
	return char and char:FindFirstChild("HumanoidRootPart")
end

local function inArc(attackerPos, attackerLook, targetPos, range, halfAngleDeg)
	local offset = targetPos - attackerPos
	local dist = offset.Magnitude
	if dist > range or dist < 0.05 then return false end
	local dir = offset.Unit
	local dot = attackerLook:Dot(dir)
	local cosHalf = math.cos(math.rad(halfAngleDeg))
	return dot >= cosHalf
end

remote.OnServerEvent:Connect(function(player, action, payload)
	if action ~= "Swing" then return end
	if typeof(payload) ~= "table" then return end
	local weaponName = payload.weapon
	local cfg = Weapons[weaponName]
	if not cfg then return end

	-- rate limit / per-player cooldown table
	if not CombatService.CanSwing(player, weaponName, cfg.cooldown) then return end

	local hrp = getHRP(player)
	if not hrp then return end
	local look = hrp.CFrame.LookVector
	local pos = hrp.Position

	for _, other in ipairs(Players:GetPlayers()) do
		if other ~= player then
			local otherHRP = getHRP(other)
			local hum = other.Character and other.Character:FindFirstChildOfClass("Humanoid")
			if otherHRP and hum and hum.Health > 0 then
				if inArc(pos, look, otherHRP.Position, cfg.range, cfg.arcHalfAngle) then
					hum:TakeDamage(cfg.damage)
					-- optional: tag killer for kill credit
					remote:FireAllClients("HitFx", {
						from = player.UserId,
						to = other.UserId,
						weapon = weaponName,
					})
				end
			end
		end
	end
end)
```

## Alternative hit methods

| Method | Good for | Notes |
|--------|----------|-------|
| Magnitude + arc | Melee | Cheap, good enough for most swords |
| Raycast | Guns, precise melee | `workspace:Raycast` from server HRP |
| GetPartBoundsInBox | Big AoE | Server creates overlap params |
| Client hitbox + server validate | Fast paced | Client sends target id; server still checks distance/angle |

Never let the client say `damage = 999`.

## Guns (server raycast)

```lua
local result = workspace:Raycast(origin, direction * maxDist, rayParams)
if result and result.Instance then
	local model = result.Instance:FindFirstAncestorOfClass("Model")
	local hum = model and model:FindFirstChildOfClass("Humanoid")
	if hum then
		hum:TakeDamage(cfg.damage)
	end
end
```

`RaycastParams.FilterDescendantsInstances` should exclude the shooter character.

## Damage metadata

```lua
hum:SetAttribute("LastAttacker", player.UserId)
hum:SetAttribute("LastWeapon", weaponName)
```

Use on `Humanoid.Died` for kill feeds and rewards (grant rewards **only** on server).

## VFX replication

Server fires `HitFx` / `SwingFx` to clients. Each client plays particles and sounds locally. Do not parent particle emitters from the server for every bullet in high-fire-rate guns — prefer client-side presentation.

## Anti-exploit reminders

- Cooldowns stored on server, not client.
- Max damage per second soft-cap optional.
- Reject swings if Humanoid.Health <= 0 or character missing.
- For competitive games, consider short server-side lag compensation (rewind HRP using recent position history) — advanced; start without it.

## References

- Remote validation → `roblox-networking`
- Where to put CombatService → `roblox-modules-architecture`
