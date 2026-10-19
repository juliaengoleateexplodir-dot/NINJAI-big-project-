# Gui2Lua Serialization & Export

## luaValue helper

```lua
function F.luaValue(value)
	local t = typeof(value)
	if t == "string" then
		return string.format("%q", value)
	elseif t == "boolean" or t == "number" then
		return tostring(value)
	elseif t == "UDim2" then
		return string.format("UDim2.new(%s, %s, %s, %s)",
			F.round(value.X.Scale, 4), value.X.Offset,
			F.round(value.Y.Scale, 4), value.Y.Offset)
	elseif t == "UDim" then
		return string.format("UDim.new(%s, %s)",
			F.round(value.Scale, 4), value.Offset)
	elseif t == "Color3" then
		return string.format("Color3.fromRGB(%d, %d, %d)",
			math.floor(value.R * 255 + 0.5),
			math.floor(value.G * 255 + 0.5),
			math.floor(value.B * 255 + 0.5))
	elseif t == "Vector2" then
		return string.format("Vector2.new(%s, %s)",
			F.round(value.X, 4), F.round(value.Y, 4))
	elseif t == "EnumItem" then
		return "Enum." .. tostring(value.EnumType) .. "." .. value.Name
	elseif t == "ColorSequence" then
		local parts = {}
		for _, kp in ipairs(value.Keypoints) do
			table.insert(parts, string.format(
				"ColorSequenceKeypoint.new(%s, %s)",
				F.round(kp.Time, 4), F.luaValue(kp.Value)))
		end
		return "ColorSequence.new({" .. table.concat(parts, ", ") .. "})"
	elseif t == "NumberSequence" then
		local parts = {}
		for _, kp in ipairs(value.Keypoints) do
			if kp.Envelope and kp.Envelope ~= 0 then
				table.insert(parts, string.format(
					"NumberSequenceKeypoint.new(%s, %s, %s)",
					F.round(kp.Time, 4), F.round(kp.Value, 4), F.round(kp.Envelope, 4)))
			else
				table.insert(parts, string.format(
					"NumberSequenceKeypoint.new(%s, %s)",
					F.round(kp.Time, 4), F.round(kp.Value, 4)))
			end
		end
		return "NumberSequence.new({" .. table.concat(parts, ", ") .. "})"
	elseif t == "Rect" then
		return string.format("Rect.new(%s, %s, %s, %s)",
			F.round(value.Min.X, 4), F.round(value.Min.Y, 4),
			F.round(value.Max.X, 4), F.round(value.Max.Y, 4))
	elseif t == "Font" then
		return string.format("Font.new(%q, Enum.FontWeight.%s, Enum.FontStyle.%s)",
			value.Family, value.Weight.Name, value.Style.Name)
	else
		return tostring(value)
	end
end
```

## Export walk

```lua
function F.exportToLua(options)
	options = options or {}
	local lines = {}
	local varCount = 0

	local function nextKey(className)
		varCount = varCount + 1
		local safe = className:gsub("[^%w_]", "")
		if safe == "" then safe = "Obj" end
		return safe .. "_" .. varCount
	end

	-- ASCII art header (optional but characteristic of Gui2Lua)
	table.insert(lines, "--[=[")
	table.insert(lines, "designed using GuiBuilderTool - Enhanced Gui2Lua style")
	table.insert(lines, "]=]")
	table.insert(lines, "")
	table.insert(lines, "local Players = game:GetService(\"Players\")")
	table.insert(lines, "local G2L = {}")
	table.insert(lines, "")

	local function exportInstance(inst, parentKey)
		if F.isOverlay(inst) then return end
		local className = inst.ClassName
		local props = State.EXPORTABLE_PROPS[className]
		local key = nextKey(className)

		if options.comments then
			table.insert(lines, string.format("-- %s : %q", className, inst.Name))
		end

		if parentKey then
			table.insert(lines, string.format(
				"G2L[%q] = Instance.new(%q, G2L[%q])", key, className, parentKey))
		else
			table.insert(lines, string.format(
				"G2L[%q] = Instance.new(%q)", key, className))
		end

		table.insert(lines, string.format("G2L[%q][\"Name\"] = %q", key, inst.Name))

		if props then
			for _, propName in ipairs(props) do
				if propName ~= "Name" then
					local ok, value
					if propName == "Source" and (inst:IsA("LocalScript") or inst:IsA("ModuleScript")) then
						value = F.getScriptSource(inst)
						ok = type(value) == "string"
					else
						ok, value = pcall(function() return inst[propName] end)
					end
					if ok and value ~= nil then
						if propName == "Size" and options.autoSizeScale and inst:IsA("GuiObject") then
							local parentObj = inst.Parent
							local parentSize = (parentObj and parentObj:IsA("GuiObject"))
								and parentObj.AbsoluteSize or inst.AbsoluteSize
							local sx = parentSize.X > 0 and (inst.AbsoluteSize.X / parentSize.X) or 0
							local sy = parentSize.Y > 0 and (inst.AbsoluteSize.Y / parentSize.Y) or 0
							table.insert(lines, string.format(
								"G2L[%q][\"Size\"] = UDim2.new(%s, 0, %s, 0)",
								key, F.round(sx, 4), F.round(sy, 4)))
						elseif propName == "Position" and options.autoPositionScale and inst:IsA("GuiObject") then
							-- relative scale from AbsolutePosition
							-- ...
						elseif propName == "Source" then
							table.insert(lines, string.format(
								"G2L[%q][\"Source\"] = %s", key, string.format("%q", tostring(value))))
						else
							table.insert(lines, string.format(
								"G2L[%q][%q] = %s", key, propName, F.luaValue(value)))
						end
					end
				end
			end
		end

		if not parentKey and className == "ScreenGui" then
			table.insert(lines, string.format(
				"G2L[%q].Parent = Players.LocalPlayer:WaitForChild(\"PlayerGui\")", key))
		end

		if options.autoAddConstraint and inst:IsA("GuiObject") and inst.AbsoluteSize.Y > 0 then
			local ratio = inst.AbsoluteSize.X / inst.AbsoluteSize.Y
			local cKey = key .. "_Ratio"
			table.insert(lines, string.format(
				"G2L[%q] = Instance.new(\"UIAspectRatioConstraint\", G2L[%q])", cKey, key))
			table.insert(lines, string.format(
				"G2L[%q][\"AspectRatio\"] = %s", cKey, F.round(ratio, 3)))
		end

		table.insert(lines, "")
		for _, child in ipairs(inst:GetChildren()) do
			exportInstance(child, key)
		end
		return key
	end

	local rootKey = exportInstance(State.projectGui, nil)
	table.insert(lines, "return G2L[" .. string.format("%q", rootKey or "ScreenGui_1") .. "]")
	return table.concat(lines, "\n")
end
```

## Options exposed in the UI

- `autoSizeScale` — convert Size to scale relative to parent
- `autoPositionScale` — convert Position to scale relative to parent
- `autoAddConstraint` — inject UIAspectRatioConstraint
- `comments` — emit `-- ClassName : "Name"` lines

## Mobile / large code

Split output into chunks of ~8 000–20 000 characters when the device is touch-only or the string is huge. Provide Prev / Next navigation in the code output window.
