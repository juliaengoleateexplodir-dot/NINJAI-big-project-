---
name: roblox-advanced-gui
description: Teach and generate advanced Roblox ScreenGui code using patterns from GuiBuilderTool — themes, virtualized Explorer, property panels, animated dropdowns, bounding-box drag and resize with snap guides, UIGradient editors, smooth UIDragDetector, source editors, undo/redo history, Gui2Lua export, import, and responsive UIScale. Use when the user asks for professional Roblox UI tooling, a GUI builder, advanced interface systems, gradient drag, or production-ready LocalScript UI code.
---

# Roblox Advanced GUI (GuiBuilderTool patterns)

Produce production-quality Roblox UI systems by following the architecture and implementation patterns of **GuiBuilderTool V4**. Prefer these patterns over ad-hoc Frame + TextButton scripts.

## Core architecture

Keep three shared tables at module/script top level to stay under Luau register limits:

```lua
local UI = {}      -- all GuiObject references
local State = {}   -- runtime state, themes, selection, history
local F = {}       -- functions (never put heavy logic in free locals)
```

Always create the root like this:

```lua
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- destroy previous instance of the tool
local old = PlayerGui:FindFirstChild("GuiBuilderTool")
if old then old:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GuiBuilderTool"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder = 1000
screenGui.IgnoreGuiInset = true
screenGui.Parent = PlayerGui
```

Helper that every element should go through:

```lua
function F.new(className, props, children)
	local inst = Instance.new(className)
	if State.BORDERED_CLASSES[className] then
		inst.BorderSizePixel = 0
	end
	for k, v in pairs(props or {}) do
		inst[k] = v
	end
	for _, child in ipairs(children or {}) do
		child.Parent = inst
	end
	return inst
end
```

Mark internal overlays with a `__` name prefix and never export or select them:

```lua
function F.isOverlay(inst)
	return inst.Name:sub(1, 2) == "__"
end
```

## Themes

Store complete color tables and apply them in one pass:

```lua
State.THEMES = {
	Black = {
		Background = Color3.fromRGB(24, 24, 24),
		Panel = Color3.fromRGB(32, 32, 32),
		PanelAlt = Color3.fromRGB(40, 40, 40),
		Divider = Color3.fromRGB(50, 50, 50),
		Button = Color3.fromRGB(45, 45, 45),
		ButtonHover = Color3.fromRGB(58, 58, 58),
		Accent = Color3.fromRGB(90, 130, 200),
		Text = Color3.fromRGB(225, 225, 225),
		SubText = Color3.fromRGB(160, 160, 160),
		RowSelected = Color3.fromRGB(55, 70, 90),
		Danger = Color3.fromRGB(180, 60, 60),
	},
	White = { -- inverted palette
		Background = Color3.fromRGB(245, 245, 245),
		-- ...
	},
}
State.THEME = {}
for k, v in pairs(State.THEMES.Black) do State.THEME[k] = v end
```

`F.applyTheme(name)` must recolor every window top bar, list, button and then call `F.refreshExplorer()` / `F.refreshProperties()`.

Optional UI transparency:

```lua
State.uiTransparencyEnabled = false
State.UI_TRANSPARENCY_AMOUNT = 0.35

function F.getTargetWindowTransparency()
	return State.uiTransparencyEnabled and State.UI_TRANSPARENCY_AMOUNT or 0
end
```

Fade windows with `TweenService` + `BackgroundTransparency` instead of instant `Visible` toggles.

## Draggable windows

```lua
function F.makeDraggable(frame, handle)
	local dragging, dragStart, startPos
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
end
```

Always attach drag to the top bar only, never the whole content area.

## Animated dropdowns

One global active dropdown. Always open **below** the anchor button. Rotate the arrow 180°.

Key pieces:

- `State.activeDropdownClose` / `State.activeDropdownAnchor`
- `F.attachDropdownArrow(btn)` — pads right, adds ImageLabel named `DropdownArrow`
- `F.setDropdownArrow(btn, open)` — tween Rotation 0 ↔ 180
- `F.openAnimatedDropdown(anchorBtn, items, currentLabel, onSelect, opts)`

Items can be strings or `{Label = "...", Value = ..., Font = Enum.Font.X}`.  
Fade + expand with `TweenInfo.new(0.45, Enum.EasingStyle.Quart)`.  
Close on outside click and when the anchor becomes invisible.  
Follow the button while the parent window is dragged (`RenderStepped`).

## Bounding box — drag, resize, snap

Selection overlay + eight handles (TL/TR/BL/BR/T/B/L/R).

```lua
State.HANDLE_SIZE = 20
State.ORANGE = Color3.fromRGB(255, 140, 0)
State.snapThreshold = 8
State.alignmentEnabled = true
```

Create a fully transparent `__BoundingBox` Frame with `UIStroke` in the **same parent** as the selected GuiObject (avoids GuiInset jumps).  

On body drag:

1. Capture start AbsolutePosition / Size / UDim Position.
2. On mouse move compute proposed abs position.
3. Call `F.snapToGuides(inst, proposedAbsPos, absSize)`.
4. Apply delta only to the Offset of Position.

On handle resize:

- Compute new width/height from delta and resize mode.
- Keep the opposite edge fixed using AnchorPoint math.
- Minimum size 16 px.

Alignment guides:

- Parent left / center / right and top / center / bottom.
- Sibling edges and centers.
- Draw 1 px magenta lines (`__AlignLine`) while dragging; clear on release.

```lua
function F.getInsetCorrection(inst)
	local node = inst
	while node and not node:IsA("ScreenGui") do
		node = node.Parent
	end
	if node and node.IgnoreGuiInset then
		return Vector2.new(0, 0)
	end
	return GuiService:GetGuiInset()
end
```

Always correct positions with the inset of the source ScreenGui.

## Virtualized Explorer (anti-lag)

Never create one row per instance for large trees. Keep a flat list and a pool of rows.

```lua
State.EXPLORER_ROW_H = 24
State.EXPLORER_BUFFER_ROWS = 4
State.ANTI_LAG_BIG_TREE = 800
State.explorerFlat = { count = 0, inst = {}, depth = {}, ... }
State.explorerPool / explorerFree / explorerActive
```

`F.buildExplorerFlat()` walks the tree with an explicit stack (no recursion limit).  
Collapsed nodes hide children (`State.collapsed` weak table).  
`F.renderExplorerRows(force)` only materializes rows inside the visible canvas + buffer.  
Canvas width is driven by the longest name (`#name * 7` px estimate).

Tree connector lines are thin orange Frames drawn per row.  
Collapse arrow rotates between 0° (open) and -90° (closed).

### Explorer drag-and-drop

- Mouse: press selected row + move > 6 px → start drag.
- Touch: hold 0.35 s without moving > 10 px → start drag.
- Ghost frame follows pointer; list auto-scrolls near edges.
- Drop only if `F.canDropInto(drag, target)` (no self, no descendant, no current parent).

### Undo / Redo

```lua
State.undoStack, State.redoStack
State.HISTORY_LIMIT = 100

-- entry shape
{
	undo = function() → boolean,
	redo = function() → boolean,
	dropFromUndo = function()? ,  -- destroy detached instances
	dropFromRedo = function()? ,
}
```

Record for add, delete, reparent, rename. Never destroy on delete — only set `Parent = nil` so undo can restore.

## Properties panel

Drive everything from a schema table:

```lua
State.PROPERTY_SCHEMA = {
	{Key = "BackgroundColor3", Label = "Background color", Type = "color"},
	{Key = "Size", Label = "Size", Type = "udim2"},
	{Key = "Font", Label = "Font", Type = "enum", Enum = Enum.Font},
	{Key = "Source", Label = "Source (Use)", Type = "source"},
	-- OnlyClass filter for Sound etc.
}
```

Supported types and UI:

| Type       | Control                                      |
|------------|----------------------------------------------|
| readonly   | TextLabel                                    |
| bool       | ImageButton toggle                           |
| string     | TextBox (auto rbxassetid:// for Image/Video) |
| number     | TextBox                                      |
| color      | Swatch → color picker; ColorSequence → gradient editor |
| vector2    | two TextBoxes                                |
| udim       | Scale + Offset                               |
| udim2      | four TextBoxes                               |
| rect       | four TextBoxes                               |
| enum       | animated dropdown (Font preview uses item Font) |
| source     | button that opens Source Editor              |

Search filters schema by label. Special rows for ScrollingFrame corner and UIDragDetector joystick/speed.

## UIGradient editor

Full keypoint editor:

- Horizontal gradient bar.
- Draggable markers for each keypoint.
- Time TextBox + color swatch.
- Add / Remove / Reset keypoints.
- Live write-back:

```lua
local seq = ColorSequence.new(keypoints)
gradientInstance.Color = seq
```

Open from any ColorSequence property row.

## Smooth UIDragDetector

Attributes:

- `DragJoystickMode` = `"Joystick"` | `"No Joystick"`
- `DragSpeed` = 0.02 … 1 (1 = instant)

When speed < 1, install a constraint function that lerps position every `RenderStepped` frame:

```lua
local alpha = 1 - (1 - speed) ^ (dt * 60)
smoothed = smoothed:Lerp(target, alpha)
parent.Position = parent.Position + (nextValue - smoothed)
```

Optionally hide the mobile thumbstick visually while dragging (`TouchGui` DynamicThumbstickFrame).

## Source editor for LocalScript / ModuleScript

Separate draggable window with multiline Code TextBox.  
On open:

- If the script belongs to the game and Source is protected, call executor `decompile`.
- Otherwise read cached / live Source.

Save writes back through `F.setScriptSource`.

## Gui2Lua export

Recursive walk of `State.projectGui`:

```lua
local function exportInstance(inst, parentKey)
	local key = nextKey(inst.ClassName)
	-- G2L["Frame_1"] = Instance.new("Frame", G2L["ScreenGui_1"])
	-- set every EXPORTABLE_PROPS[className]
	-- optional auto Size/Position scale
	-- optional UIAspectRatioConstraint
	for _, child in ipairs(inst:GetChildren()) do
		if not F.isOverlay(child) then
			exportInstance(child, key)
		end
	end
end
```

Header style:

```lua
--[=[
 d888b  db    db d888888b ...
designed using GuiBuilderTool - Enhanced Gui2Lua style
]=]
local G2L = {}
-- ...
return G2L["ScreenGui_1"]
```

Support chunking for mobile clipboard limits (~8k–20k chars).

`F.luaValue` must correctly serialize UDim2, Color3, Vector2, EnumItem, ColorSequence, NumberSequence, Rect, Font.

## Import

Parse Gui2Lua / G2L sources (including embedded LocalScript and ModuleScript Source) and rebuild the instance tree under the project root.

## Responsive layout

Every tool window receives a child `UIScale` named `__ResponsiveScale`.

```lua
function F.getBaseScale(vp)
	local touchOnly = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
	if touchOnly then
		return math.clamp(vp.Y / 800, 1, 1.5)
	end
	return math.clamp(vp.Y / 1080, 1, 2.5)
end
```

Clamp windows inside the viewport on resize / orientation change. Never scale the user’s project GUI or selection guides.

## Class defaults & icons

Provide sensible defaults for every creatable class (Frame, TextButton, ScrollingFrame with CanvasSize > Size, UICorner 8 px, LocalScript starter source, etc.).

Class icons come from a single atlas:

```lua
State.CLASS_ICON_ATLAS = "rbxassetid://..."
State.CLASS_ICON_CELL = 32
State.CLASS_ICON_CELLS = {
	Frame = {6, 6},
	TextButton = {14, 13},
	-- column, row from top-left
}
```

## Settings persistence

Save theme, alignment toggle, highlight color, UI transparency, etc. under a fixed key (`GuiBuilderTool_Settings_v1`) with the executor’s file / DataStore API when available.

## Checklist when generating a new advanced GUI tool

1. Shared `UI` / `State` / `F` tables.
2. Theme system + apply function.
3. Draggable windows with top-bar handles only.
4. Animated dropdown utility used by properties and settings.
5. Selection + bounding box with snap guides.
6. Virtualized explorer with collapse, drag-drop, undo/redo.
7. Schema-driven properties panel.
8. Gradient editor for ColorSequence.
9. Smooth UIDragDetector optional attributes.
10. Source editor for scripts.
11. Gui2Lua export that respects EXPORTABLE_PROPS and serializes every Roblox type correctly.
12. Responsive UIScale that never touches the user’s project.
13. Overlay naming convention `__` and IgnoreGuiInset awareness.

## References

- Detailed property schema and exportable props → `references/property-schema.md`
- Bounding-box and snap math → `references/bounding-box.md`
- Gui2Lua serialization helpers → `references/gui2lua.md`

When the user asks for “a GUI builder”, “advanced Roblox UI”, “gradient editor”, “drag with snap”, or “Gui2Lua style code”, generate complete LocalScripts that follow the patterns above instead of minimal Frame examples.
