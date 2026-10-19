---
name: roblox-animations
description: Teach Roblox animation systems — Animator, AnimationTracks, markers, blending, tool animations, and client-server animation replication. Use when the user asks about playing animations, AnimationController, keyframe markers, or character animation code.
---

# Roblox Animations

## Core objects

- `Humanoid` or `AnimationController` owns an `Animator`.
- `Animator:LoadAnimation(animation)` → `AnimationTrack`.
- Track methods: `Play`, `Stop`, `AdjustSpeed`, `AdjustWeight`, `GetMarkerReachedSignal`.

Prefer the modern path:

```lua
local humanoid = character:WaitForChild("Humanoid")
local animator = humanoid:FindFirstChildOfClass("Animator")
if not animator then
	animator = Instance.new("Animator")
	animator.Parent = humanoid
end

local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://1234567890"

local track = animator:LoadAnimation(anim)
track.Priority = Enum.AnimationPriority.Action
track:Play()
```

## Priorities

| Priority | Typical use |
|----------|-------------|
| Core | Locomotion (walk, idle) from Animate script |
| Idle | Extra idle layers |
| Movement | Run overlays |
| Action | Attacks, reloads |
| Action2–4 | Higher priority actions |
| Action (highest needed wins) | |

Only one track at the same priority fully blends unless you manage weights.

## Markers (events inside the animation)

In the Animation Editor, add markers (e.g. `Hit`, `Footstep`).

```lua
track:GetMarkerReachedSignal("Hit"):Connect(function(paramString)
	-- server or client reaction
end)
```

For combat, prefer server-side timing (cooldown + fixed delay) over trusting client markers for damage. Markers are great for VFX and sounds.

## Client vs server playback

- **Visual only** (emotes, menu): play on client.
- **Gameplay-critical** (attack windows): server can play the track on the character so all clients see it, or server fires a remote and each client plays locally (often smoother).

```lua
-- Server tells everyone to play a swing on that character
fxRemote:FireAllClients("PlayAnim", character, "SwordSwing")
```

```lua
-- Client
fxRemote.OnClientEvent:Connect(function(kind, character, animName)
	if kind == "PlayAnim" then
		local track = loadCached(character, animName)
		track:Play()
	end
end)
```

Cache tracks per character to avoid reloading every swing.

## Tool animations

Connect to `Tool.Activated` / `Equipped`. Stop previous action tracks before playing a new one.

```lua
local current
local function play(id, priority)
	if current and current.IsPlaying then current:Stop(0.1) end
	local track = animator:LoadAnimation(makeAnim(id))
	track.Priority = priority or Enum.AnimationPriority.Action
	track:Play()
	current = track
	return track
end
```

## Blending and stops

```lua
track:Play(0.15)  -- fade in
track:Stop(0.2)   -- fade out
track:AdjustWeight(0.5, 0.1)
```

## Animate script

Default character ships with an Animate LocalScript. Custom locomotion either:

1. Fork and modify Animate, or
2. Set `Humanoid.WalkSpeed` / states and let Animate handle walk/idle, while your Action tracks layer on top.

## Checklist

1. Use Animator:LoadAnimation, not humanoid:LoadAnimation (deprecated path).
2. Set Priority explicitly.
3. Cache tracks when the same anim plays often.
4. Do not grant damage from client-side marker signals alone.
5. Clean up tracks on character respawn (new character → new Animator).

## References

- Combat swing timing → `roblox-combat-systems`
- Client presentation layer → `roblox-client-server`
