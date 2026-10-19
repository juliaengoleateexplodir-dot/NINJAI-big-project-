---
name: roblox-pathfinding-ai
description: Teach Roblox PathfindingService and simple NPC AI — ComputeAsync, waypoints, agent parameters, blocked path recovery, and chase / patrol loops. Use when the user asks about pathfinding, NPC AI, bots, zombies, or moving characters along a path.
---

# Pathfinding & Simple NPC AI

## Basic path

```lua
local PathfindingService = game:GetService("PathfindingService")

local path = PathfindingService:CreatePath({
	AgentRadius = 2,
	AgentHeight = 5,
	AgentCanJump = true,
	AgentCanClimb = false,
	WaypointSpacing = 4,
	Costs = {
		Water = 100, -- avoid water
	},
})

local function follow(humanoid, hrp, destination)
	local ok, err = pcall(function()
		path:ComputeAsync(hrp.Position, destination)
	end)
	if not ok or path.Status ~= Enum.PathStatus.Success then
		return false
	end

	local waypoints = path:GetWaypoints()
	for i, wp in ipairs(waypoints) do
		if wp.Action == Enum.PathWaypointAction.Jump then
			humanoid.Jump = true
		end
		humanoid:MoveTo(wp.Position)
		local finished = humanoid.MoveToFinished:Wait()
		if not finished then
			return false -- interrupted
		end
	end
	return true
end
```

Always `pcall` ComputeAsync — it can throw.

## Blocked path recovery

```lua
path.Blocked:Connect(function(blockedWaypointIndex)
	-- recompute from current position to same goal
end)
```

Or on MoveToFinished == false, recompute.

## Patrol AI loop

```lua
local points = { workspace.P1.Position, workspace.P2.Position, workspace.P3.Position }
local idx = 1

task.spawn(function()
	while npc.Parent do
		local hum = npc:FindFirstChildOfClass("Humanoid")
		local hrp = npc:FindFirstChild("HumanoidRootPart")
		if hum and hrp and hum.Health > 0 then
			follow(hum, hrp, points[idx])
			idx = idx % #points + 1
		end
		task.wait(0.5)
	end
end)
```

## Chase player

```lua
local DETECT = 60
local ATTACK = 4

local function nearestPlayer(fromPos)
	local best, bestDist
	for _, p in ipairs(Players:GetPlayers()) do
		local hrp = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			local d = (hrp.Position - fromPos).Magnitude
			if d < (bestDist or math.huge) then
				best, bestDist = hrp, d
			end
		end
	end
	return best, bestDist
end

-- in loop:
local target, dist = nearestPlayer(hrp.Position)
if target and dist <= DETECT then
	if dist <= ATTACK then
		-- attack intent / animation
	else
		follow(hum, hrp, target.Position)
	end
else
	-- idle / patrol
end
```

Recompute path every 0.5–1 s while chasing; do not ComputeAsync every frame.

## Agent parameters tips

- `AgentRadius` too small → path through tight gaps the character cannot fit.
- `AgentRadius` too big → fails in narrow corridors.
- Match `AgentHeight` to character hip height roughly.
- `WaypointSpacing` lower = denser waypoints = smoother but more MoveTo calls.

## Performance

- Limit simultaneous path computes (queue NPCs).
- Disable pathfinding for NPCs far from all players.
- Use simple magnitude chase when very close instead of full path.

## Server-only

Run NPC logic on the server. Clients only see the replicated Humanoid movement. Do not trust client to move enemy NPCs.

## References

- Server authority → `roblox-client-server`
- Attack integration → `roblox-combat-systems`
