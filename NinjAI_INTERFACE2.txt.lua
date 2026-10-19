--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88    @uniquadev
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  CONVERTER 

designed using GuiBuilderTool - Enhanced Gui2Lua style
NINJ AI Interface v3 — tabs layout fix, New Chat instant, AI action icons
]=]

-- Services
local Players = game:GetService("Players")

-- Reexecução: destrói a instância anterior (evita GUI e conexões duplicadas)
if shared.NinjUI and type(shared.NinjUI.Destroy) == "function" then
	pcall(shared.NinjUI.Destroy)
end

local G2L = {}

G2L["ScreenGui_1"] = Instance.new("ScreenGui")
G2L["ScreenGui_1"]["Name"] = "Screengui"
G2L["ScreenGui_1"]["ResetOnSpawn"] = false
G2L["ScreenGui_1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Global
G2L["ScreenGui_1"]["DisplayOrder"] = 0
G2L["ScreenGui_1"]["IgnoreGuiInset"] = false
G2L["ScreenGui_1"]["Enabled"] = true
G2L["ScreenGui_1"]["ClipToDeviceSafeArea"] = true
G2L["ScreenGui_1"].Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

G2L["Frame_2"] = Instance.new("Frame", G2L["ScreenGui_1"])
G2L["Frame_2"]["Name"] = "Frame1"
G2L["Frame_2"]["Size"] = UDim2.new(0, 479, 0, 310)
G2L["Frame_2"]["Position"] = UDim2.new(0.5, 0, 0.5, 0)
G2L["Frame_2"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
G2L["Frame_2"]["Rotation"] = 0
G2L["Frame_2"]["BackgroundColor3"] = Color3.fromRGB(16, 16, 16)
G2L["Frame_2"]["BackgroundTransparency"] = 0
G2L["Frame_2"]["BorderColor3"] = Color3.fromRGB(27, 42, 53)
G2L["Frame_2"]["BorderSizePixel"] = 0
G2L["Frame_2"]["ClipsDescendants"] = true
G2L["Frame_2"]["Visible"] = true
G2L["Frame_2"]["ZIndex"] = 1
G2L["Frame_2"]["Active"] = false
G2L["Frame_2"]["Selectable"] = false
G2L["Frame_2"]["LayoutOrder"] = 0
G2L["Frame_2"]["AutomaticSize"] = Enum.AutomaticSize.None

G2L["Frame_3"] = Instance.new("Frame", G2L["Frame_2"])
G2L["Frame_3"]["Name"] = "Sidebar"
G2L["Frame_3"]["Size"] = UDim2.new(0.1984, 0, 1, 0)
G2L["Frame_3"]["Position"] = UDim2.new(-0.02, 0, 0, 0)
G2L["Frame_3"]["AnchorPoint"] = Vector2.new(0, 0)
G2L["Frame_3"]["Rotation"] = 0
G2L["Frame_3"]["BackgroundColor3"] = Color3.fromRGB(28, 28, 28)
G2L["Frame_3"]["BackgroundTransparency"] = 0
G2L["Frame_3"]["BorderColor3"] = Color3.fromRGB(27, 42, 53)
G2L["Frame_3"]["BorderSizePixel"] = 0
G2L["Frame_3"]["ClipsDescendants"] = true
G2L["Frame_3"]["Visible"] = true
G2L["Frame_3"]["ZIndex"] = 1
G2L["Frame_3"]["Active"] = false
G2L["Frame_3"]["Selectable"] = false
G2L["Frame_3"]["LayoutOrder"] = 0
G2L["Frame_3"]["AutomaticSize"] = Enum.AutomaticSize.None

G2L["TextButton_4"] = Instance.new("TextButton", G2L["Frame_3"])
G2L["TextButton_4"]["Name"] = "NewChat"
G2L["TextButton_4"]["Size"] = UDim2.new(1.0303, 0, 0.0959, 0)
G2L["TextButton_4"]["Position"] = UDim2.new(0, 0, 0, 0)
G2L["TextButton_4"]["AnchorPoint"] = Vector2.new(0, 0)
G2L["TextButton_4"]["Rotation"] = 0
G2L["TextButton_4"]["BackgroundColor3"] = Color3.fromRGB(40, 40, 40)
G2L["TextButton_4"]["BackgroundTransparency"] = 0
G2L["TextButton_4"]["BorderSizePixel"] = 0
G2L["TextButton_4"]["Visible"] = true
G2L["TextButton_4"]["ZIndex"] = 1
G2L["TextButton_4"]["Text"] = "New Chat"
G2L["TextButton_4"]["TextColor3"] = Color3.fromRGB(240, 240, 240)
G2L["TextButton_4"]["TextSize"] = 14
G2L["TextButton_4"]["Font"] = Enum.Font.Gotham
G2L["TextButton_4"]["TextScaled"] = false
G2L["TextButton_4"]["TextWrapped"] = false
G2L["TextButton_4"]["TextXAlignment"] = Enum.TextXAlignment.Center
G2L["TextButton_4"]["TextYAlignment"] = Enum.TextYAlignment.Center
G2L["TextButton_4"]["TextTransparency"] = 0
G2L["TextButton_4"]["TextStrokeColor3"] = Color3.fromRGB(0, 0, 0)
G2L["TextButton_4"]["TextStrokeTransparency"] = 1
G2L["TextButton_4"]["TextTruncate"] = Enum.TextTruncate.None
G2L["TextButton_4"]["RichText"] = false
G2L["TextButton_4"]["Active"] = true
G2L["TextButton_4"]["AutoButtonColor"] = true
G2L["TextButton_4"]["LayoutOrder"] = 0

G2L["TextButton_5"] = Instance.new("TextButton", G2L["Frame_3"])
G2L["TextButton_5"]["Name"] = "Chat 1"
G2L["TextButton_5"]["Size"] = UDim2.new(1.0303, 0, 0.0959, 0)
G2L["TextButton_5"]["Position"] = UDim2.new(0, 0, 0.1404, 0)
G2L["TextButton_5"]["AnchorPoint"] = Vector2.new(0, 0)
G2L["TextButton_5"]["Rotation"] = 0
G2L["TextButton_5"]["BackgroundColor3"] = Color3.fromRGB(40, 40, 40)
G2L["TextButton_5"]["BackgroundTransparency"] = 0
G2L["TextButton_5"]["BorderSizePixel"] = 0
G2L["TextButton_5"]["Visible"] = true
G2L["TextButton_5"]["ZIndex"] = 1
G2L["TextButton_5"]["Text"] = "Chat1"
G2L["TextButton_5"]["TextColor3"] = Color3.fromRGB(240, 240, 240)
G2L["TextButton_5"]["TextSize"] = 14
G2L["TextButton_5"]["Font"] = Enum.Font.Gotham
G2L["TextButton_5"]["TextScaled"] = false
G2L["TextButton_5"]["TextWrapped"] = false
G2L["TextButton_5"]["TextXAlignment"] = Enum.TextXAlignment.Center
G2L["TextButton_5"]["TextYAlignment"] = Enum.TextYAlignment.Center
G2L["TextButton_5"]["TextTransparency"] = 0
G2L["TextButton_5"]["TextStrokeColor3"] = Color3.fromRGB(0, 0, 0)
G2L["TextButton_5"]["TextStrokeTransparency"] = 1
G2L["TextButton_5"]["TextTruncate"] = Enum.TextTruncate.None
G2L["TextButton_5"]["RichText"] = false
G2L["TextButton_5"]["Active"] = true
G2L["TextButton_5"]["AutoButtonColor"] = true
G2L["TextButton_5"]["LayoutOrder"] = 0

G2L["TextButton_6"] = Instance.new("TextButton", G2L["Frame_3"])
G2L["TextButton_6"]["Name"] = "Chat 2"
G2L["TextButton_6"]["Size"] = UDim2.new(1.0303, 0, 0.0959, 0)
G2L["TextButton_6"]["Position"] = UDim2.new(0, 0, 0.2705, 0)
G2L["TextButton_6"]["AnchorPoint"] = Vector2.new(0, 0)
G2L["TextButton_6"]["Rotation"] = 0
G2L["TextButton_6"]["BackgroundColor3"] = Color3.fromRGB(40, 40, 40)
G2L["TextButton_6"]["BackgroundTransparency"] = 0
G2L["TextButton_6"]["BorderSizePixel"] = 0
G2L["TextButton_6"]["Visible"] = true
G2L["TextButton_6"]["ZIndex"] = 1
G2L["TextButton_6"]["Text"] = "Chat2"
G2L["TextButton_6"]["TextColor3"] = Color3.fromRGB(240, 240, 240)
G2L["TextButton_6"]["TextSize"] = 14
G2L["TextButton_6"]["Font"] = Enum.Font.Gotham
G2L["TextButton_6"]["TextScaled"] = false
G2L["TextButton_6"]["TextWrapped"] = false
G2L["TextButton_6"]["TextXAlignment"] = Enum.TextXAlignment.Center
G2L["TextButton_6"]["TextYAlignment"] = Enum.TextYAlignment.Center
G2L["TextButton_6"]["TextTransparency"] = 0
G2L["TextButton_6"]["TextStrokeColor3"] = Color3.fromRGB(0, 0, 0)
G2L["TextButton_6"]["TextStrokeTransparency"] = 1
G2L["TextButton_6"]["TextTruncate"] = Enum.TextTruncate.None
G2L["TextButton_6"]["RichText"] = false
G2L["TextButton_6"]["Active"] = true
G2L["TextButton_6"]["AutoButtonColor"] = true
G2L["TextButton_6"]["LayoutOrder"] = 0

G2L["TextLabel_7"] = Instance.new("TextLabel", G2L["Frame_2"])
G2L["TextLabel_7"]["Name"] = "TextLabel3"
G2L["TextLabel_7"]["Size"] = UDim2.new(0.2786, 0, 0.0856, 0)
G2L["TextLabel_7"]["Position"] = UDim2.new(0.3607, 0, 0, 0)
G2L["TextLabel_7"]["AnchorPoint"] = Vector2.new(0, 0)
G2L["TextLabel_7"]["Rotation"] = 0
G2L["TextLabel_7"]["BackgroundColor3"] = Color3.fromRGB(163, 162, 165)
G2L["TextLabel_7"]["BackgroundTransparency"] = 1
G2L["TextLabel_7"]["BorderSizePixel"] = 0
G2L["TextLabel_7"]["Visible"] = true
G2L["TextLabel_7"]["ZIndex"] = 1
G2L["TextLabel_7"]["Text"] = "NINJ AI"
G2L["TextLabel_7"]["TextColor3"] = Color3.fromRGB(240, 240, 240)
G2L["TextLabel_7"]["TextSize"] = 14
G2L["TextLabel_7"]["Font"] = Enum.Font.GothamBlack
G2L["TextLabel_7"]["TextScaled"] = true
G2L["TextLabel_7"]["TextWrapped"] = true
G2L["TextLabel_7"]["TextXAlignment"] = Enum.TextXAlignment.Center
G2L["TextLabel_7"]["TextYAlignment"] = Enum.TextYAlignment.Center
G2L["TextLabel_7"]["TextTransparency"] = 0
G2L["TextLabel_7"]["TextStrokeColor3"] = Color3.fromRGB(0, 0, 0)
G2L["TextLabel_7"]["TextStrokeTransparency"] = 1
G2L["TextLabel_7"]["TextTruncate"] = Enum.TextTruncate.None
G2L["TextLabel_7"]["RichText"] = false
G2L["TextLabel_7"]["LayoutOrder"] = 0

G2L["UIGradient_8"] = Instance.new("UIGradient", G2L["TextLabel_7"])
G2L["UIGradient_8"]["Name"] = "UIGradient15"
G2L["UIGradient_8"]["Color"] = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(185, 0, 255)), ColorSequenceKeypoint.new(0.5884, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.5926, Color3.fromRGB(185, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 2, 2))})
G2L["UIGradient_8"]["Transparency"] = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0)})
G2L["UIGradient_8"]["Rotation"] = 0
G2L["UIGradient_8"]["Enabled"] = true
G2L["UIGradient_8"]["Offset"] = Vector2.new(0, 0)

G2L["Frame_9"] = Instance.new("Frame", G2L["Frame_2"])
G2L["Frame_9"]["Name"] = "container"
G2L["Frame_9"]["Size"] = UDim2.new(0.996, 0, 1, 0)
G2L["Frame_9"]["Position"] = UDim2.new(0.002, 0, 0, 0)
G2L["Frame_9"]["AnchorPoint"] = Vector2.new(0, 0)
G2L["Frame_9"]["Rotation"] = 0
G2L["Frame_9"]["BackgroundColor3"] = Color3.fromRGB(60, 60, 60)
G2L["Frame_9"]["BackgroundTransparency"] = 1
G2L["Frame_9"]["BorderColor3"] = Color3.fromRGB(27, 42, 53)
G2L["Frame_9"]["BorderSizePixel"] = 0
G2L["Frame_9"]["ClipsDescendants"] = false
G2L["Frame_9"]["Visible"] = true
G2L["Frame_9"]["ZIndex"] = 1
G2L["Frame_9"]["Active"] = false
G2L["Frame_9"]["Selectable"] = false
G2L["Frame_9"]["LayoutOrder"] = 0
G2L["Frame_9"]["AutomaticSize"] = Enum.AutomaticSize.None

G2L["Frame_10"] = Instance.new("Frame", G2L["Frame_9"])
G2L["Frame_10"]["Name"] = "FramePrompt"
G2L["Frame_10"]["Size"] = UDim2.new(0.7545, 0, 0.0925, 0)
G2L["Frame_10"]["Position"] = UDim2.new(0.1831, 0, 0.8938, 0)
G2L["Frame_10"]["AnchorPoint"] = Vector2.new(0, 0)
G2L["Frame_10"]["Rotation"] = 0
G2L["Frame_10"]["BackgroundColor3"] = Color3.fromRGB(26, 26, 26)
G2L["Frame_10"]["BackgroundTransparency"] = 0
G2L["Frame_10"]["BorderColor3"] = Color3.fromRGB(27, 42, 53)
G2L["Frame_10"]["BorderSizePixel"] = 0
G2L["Frame_10"]["ClipsDescendants"] = false
G2L["Frame_10"]["Visible"] = true
G2L["Frame_10"]["ZIndex"] = 1
G2L["Frame_10"]["Active"] = false
G2L["Frame_10"]["Selectable"] = false
G2L["Frame_10"]["LayoutOrder"] = 0
G2L["Frame_10"]["AutomaticSize"] = Enum.AutomaticSize.None

G2L["UICorner_11"] = Instance.new("UICorner", G2L["Frame_10"])
G2L["UICorner_11"]["Name"] = "UICorner8"
G2L["UICorner_11"]["CornerRadius"] = UDim.new(0, 8)

G2L["TextBox_12"] = Instance.new("TextBox", G2L["Frame_10"])
G2L["TextBox_12"]["Name"] = "TextBoxPrompt"
G2L["TextBox_12"]["Size"] = UDim2.new(0.9787, 0, 1, 0)
G2L["TextBox_12"]["Position"] = UDim2.new(0.016, 0, 0, 0)
G2L["TextBox_12"]["AnchorPoint"] = Vector2.new(0, 0)
G2L["TextBox_12"]["Rotation"] = 0
G2L["TextBox_12"]["BackgroundColor3"] = Color3.fromRGB(60, 60, 60)
G2L["TextBox_12"]["BackgroundTransparency"] = 1
G2L["TextBox_12"]["BorderSizePixel"] = 0
G2L["TextBox_12"]["Visible"] = true
G2L["TextBox_12"]["ZIndex"] = 1
G2L["TextBox_12"]["Text"] = ""
G2L["TextBox_12"]["TextColor3"] = Color3.fromRGB(240, 240, 240)
G2L["TextBox_12"]["TextSize"] = 14
G2L["TextBox_12"]["Font"] = Enum.Font.Gotham
G2L["TextBox_12"]["TextScaled"] = false
G2L["TextBox_12"]["TextWrapped"] = true
G2L["TextBox_12"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["TextBox_12"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["TextBox_12"]["ClearTextOnFocus"] = false
G2L["TextBox_12"]["MultiLine"] = false
G2L["TextBox_12"]["PlaceholderText"] = "Text box"
G2L["TextBox_12"]["PlaceholderColor3"] = Color3.fromRGB(128, 128, 128)
G2L["TextBox_12"]["TextEditable"] = true
G2L["TextBox_12"]["TextTransparency"] = 0
G2L["TextBox_12"]["LayoutOrder"] = 0

G2L["ImageButton_13"] = Instance.new("ImageButton", G2L["TextBox_12"])
G2L["ImageButton_13"]["Name"] = "SendAndStop"
G2L["ImageButton_13"]["Size"] = UDim2.new(0.0627, 0, 0.8519, 0)
G2L["ImageButton_13"]["Position"] = UDim2.new(1.0082, 0, 0.0741, 0)
G2L["ImageButton_13"]["AnchorPoint"] = Vector2.new(0, 0)
G2L["ImageButton_13"]["Rotation"] = 0
G2L["ImageButton_13"]["BackgroundColor3"] = Color3.fromRGB(60, 60, 60)
G2L["ImageButton_13"]["BackgroundTransparency"] = 1
G2L["ImageButton_13"]["BorderSizePixel"] = 0
G2L["ImageButton_13"]["Visible"] = true
G2L["ImageButton_13"]["ZIndex"] = 1
G2L["ImageButton_13"]["Image"] = "rbxassetid://94251290360710"
G2L["ImageButton_13"]["ImageColor3"] = Color3.fromRGB(255, 255, 255)
G2L["ImageButton_13"]["ImageTransparency"] = 0
G2L["ImageButton_13"]["ScaleType"] = Enum.ScaleType.Stretch
G2L["ImageButton_13"]["ImageRectOffset"] = Vector2.new(0, 0)
G2L["ImageButton_13"]["ImageRectSize"] = Vector2.new(0, 0)
G2L["ImageButton_13"]["Active"] = true
G2L["ImageButton_13"]["AutoButtonColor"] = true
G2L["ImageButton_13"]["LayoutOrder"] = 0

G2L["UICorner_14"] = Instance.new("UICorner", G2L["ImageButton_13"])
G2L["UICorner_14"]["Name"] = "UICorner12_Copy14"
G2L["UICorner_14"]["CornerRadius"] = UDim.new(0, 1)

G2L["Frame_15"] = Instance.new("Frame", G2L["Frame_9"])
G2L["Frame_15"]["Name"] = "FrameUserMessage"
G2L["Frame_15"]["Size"] = UDim2.new(0.336, 0, 0.3425, 0)
G2L["Frame_15"]["Position"] = UDim2.new(0.6358, 0, 0.1918, 0)
G2L["Frame_15"]["AnchorPoint"] = Vector2.new(0, 0)
G2L["Frame_15"]["Rotation"] = 0
G2L["Frame_15"]["BackgroundColor3"] = Color3.fromRGB(31, 31, 31)
G2L["Frame_15"]["BackgroundTransparency"] = 0
G2L["Frame_15"]["BorderColor3"] = Color3.fromRGB(27, 42, 53)
G2L["Frame_15"]["BorderSizePixel"] = 0
G2L["Frame_15"]["ClipsDescendants"] = false
G2L["Frame_15"]["Visible"] = true
G2L["Frame_15"]["ZIndex"] = 1
G2L["Frame_15"]["Active"] = false
G2L["Frame_15"]["Selectable"] = false
G2L["Frame_15"]["LayoutOrder"] = 0
G2L["Frame_15"]["AutomaticSize"] = Enum.AutomaticSize.None

G2L["UICorner_16"] = Instance.new("UICorner", G2L["Frame_15"])
G2L["UICorner_16"]["Name"] = "UICorner12_Copy14_Copy18"
G2L["UICorner_16"]["CornerRadius"] = UDim.new(0, 6)

G2L["TextLabel_17"] = Instance.new("TextLabel", G2L["Frame_15"])
G2L["TextLabel_17"]["Name"] = "TextUser"
G2L["TextLabel_17"]["Size"] = UDim2.new(0.9281, 0, 0.92, 0)
G2L["TextLabel_17"]["Position"] = UDim2.new(0.018, 0, 0.04, 0)
G2L["TextLabel_17"]["AnchorPoint"] = Vector2.new(0, 0)
G2L["TextLabel_17"]["Rotation"] = 0
G2L["TextLabel_17"]["BackgroundColor3"] = Color3.fromRGB(163, 162, 165)
G2L["TextLabel_17"]["BackgroundTransparency"] = 1
G2L["TextLabel_17"]["BorderSizePixel"] = 0
G2L["TextLabel_17"]["Visible"] = true
G2L["TextLabel_17"]["ZIndex"] = 1
G2L["TextLabel_17"]["Text"] = "TESTE DE MENSAGEM DO USUÁRIO TESTE DE MENSAGEM DO USUÁRIO  TESTE DE MENSAGEM DO USUÁRIO  TESTE DE MENSAGEM DO USUÁRIO  TESTE DE MENSAGEM DO USUÁRIO  TESTE DE MENSAGEM DO USUÁRIO  "
G2L["TextLabel_17"]["TextColor3"] = Color3.fromRGB(113, 113, 113)
G2L["TextLabel_17"]["TextSize"] = 14
G2L["TextLabel_17"]["Font"] = Enum.Font.Gotham
G2L["TextLabel_17"]["TextScaled"] = false
G2L["TextLabel_17"]["TextWrapped"] = true
G2L["TextLabel_17"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["TextLabel_17"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["TextLabel_17"]["TextTransparency"] = 0
G2L["TextLabel_17"]["TextStrokeColor3"] = Color3.fromRGB(0, 0, 0)
G2L["TextLabel_17"]["TextStrokeTransparency"] = 1
G2L["TextLabel_17"]["TextTruncate"] = Enum.TextTruncate.None
G2L["TextLabel_17"]["RichText"] = false
G2L["TextLabel_17"]["LayoutOrder"] = 0

G2L["ImageLabel_18"] = Instance.new("ImageLabel", G2L["Frame_15"])
G2L["ImageLabel_18"]["Name"] = "UserPhoto"
G2L["ImageLabel_18"]["Size"] = UDim2.new(0.1317, 0, 0.21, 0)
G2L["ImageLabel_18"]["Position"] = UDim2.new(0.8204, 0, -0.24, 0)
G2L["ImageLabel_18"]["AnchorPoint"] = Vector2.new(0, 0)
G2L["ImageLabel_18"]["Rotation"] = 0
G2L["ImageLabel_18"]["BackgroundColor3"] = Color3.fromRGB(60, 60, 60)
G2L["ImageLabel_18"]["BackgroundTransparency"] = 0
G2L["ImageLabel_18"]["BorderSizePixel"] = 0
G2L["ImageLabel_18"]["Visible"] = true
G2L["ImageLabel_18"]["ZIndex"] = 1
G2L["ImageLabel_18"]["Image"] = ""
G2L["ImageLabel_18"]["ImageColor3"] = Color3.fromRGB(255, 255, 255)
G2L["ImageLabel_18"]["ImageTransparency"] = 0
G2L["ImageLabel_18"]["ScaleType"] = Enum.ScaleType.Stretch
G2L["ImageLabel_18"]["ImageRectOffset"] = Vector2.new(0, 0)
G2L["ImageLabel_18"]["ImageRectSize"] = Vector2.new(0, 0)
G2L["ImageLabel_18"]["SliceCenter"] = Rect.new(0, 0, 0, 0)
G2L["ImageLabel_18"]["SliceScale"] = 1
G2L["ImageLabel_18"]["LayoutOrder"] = 0

G2L["TextLabel_19"] = Instance.new("TextLabel", G2L["ImageLabel_18"])
G2L["TextLabel_19"]["Name"] = "NickUser"
G2L["TextLabel_19"]["Size"] = UDim2.new(5.9545, 0, 1, 0)
G2L["TextLabel_19"]["Position"] = UDim2.new(-6.1818, 0, 0, 0)
G2L["TextLabel_19"]["AnchorPoint"] = Vector2.new(0, 0)
G2L["TextLabel_19"]["Rotation"] = 0
G2L["TextLabel_19"]["BackgroundColor3"] = Color3.fromRGB(163, 162, 165)
G2L["TextLabel_19"]["BackgroundTransparency"] = 1
G2L["TextLabel_19"]["BorderSizePixel"] = 0
G2L["TextLabel_19"]["Visible"] = true
G2L["TextLabel_19"]["ZIndex"] = 1
G2L["TextLabel_19"]["Text"] = ""
G2L["TextLabel_19"]["TextColor3"] = Color3.fromRGB(240, 240, 240)
G2L["TextLabel_19"]["TextSize"] = 14
G2L["TextLabel_19"]["Font"] = Enum.Font.SourceSansBold
G2L["TextLabel_19"]["TextScaled"] = false
G2L["TextLabel_19"]["TextWrapped"] = true
G2L["TextLabel_19"]["TextXAlignment"] = Enum.TextXAlignment.Right
G2L["TextLabel_19"]["TextYAlignment"] = Enum.TextYAlignment.Center
G2L["TextLabel_19"]["TextTransparency"] = 0
G2L["TextLabel_19"]["TextStrokeColor3"] = Color3.fromRGB(0, 0, 0)
G2L["TextLabel_19"]["TextStrokeTransparency"] = 1
G2L["TextLabel_19"]["TextTruncate"] = Enum.TextTruncate.None
G2L["TextLabel_19"]["RichText"] = false
G2L["TextLabel_19"]["LayoutOrder"] = 0

G2L["UICorner_20"] = Instance.new("UICorner", G2L["ImageLabel_18"])
G2L["UICorner_20"]["Name"] = "UICorner22"
G2L["UICorner_20"]["CornerRadius"] = UDim.new(0, 2)

G2L["Frame_21"] = Instance.new("Frame", G2L["Frame_9"])
G2L["Frame_21"]["Name"] = "FrameAIMessage"
G2L["Frame_21"]["Size"] = UDim2.new(0.336, 0, 0.3425, 0)
G2L["Frame_21"]["Position"] = UDim2.new(0.2032, 0, 0.5342, 0)
G2L["Frame_21"]["AnchorPoint"] = Vector2.new(0, 0)
G2L["Frame_21"]["Rotation"] = 0
G2L["Frame_21"]["BackgroundColor3"] = Color3.fromRGB(31, 31, 31)
G2L["Frame_21"]["BackgroundTransparency"] = 0
G2L["Frame_21"]["BorderColor3"] = Color3.fromRGB(27, 42, 53)
G2L["Frame_21"]["BorderSizePixel"] = 0
G2L["Frame_21"]["ClipsDescendants"] = false
G2L["Frame_21"]["Visible"] = true
G2L["Frame_21"]["ZIndex"] = 1
G2L["Frame_21"]["Active"] = false
G2L["Frame_21"]["Selectable"] = false
G2L["Frame_21"]["LayoutOrder"] = 0
G2L["Frame_21"]["AutomaticSize"] = Enum.AutomaticSize.None

G2L["UICorner_22"] = Instance.new("UICorner", G2L["Frame_21"])
G2L["UICorner_22"]["Name"] = "UICorner12_Copy14_Copy18"
G2L["UICorner_22"]["CornerRadius"] = UDim.new(0, 6)

G2L["TextLabel_23"] = Instance.new("TextLabel", G2L["Frame_21"])
G2L["TextLabel_23"]["Name"] = "TextAI"
G2L["TextLabel_23"]["Size"] = UDim2.new(0.9701, 0, 0.95, 0)
G2L["TextLabel_23"]["Position"] = UDim2.new(0.018, 0, 0.04, 0)
G2L["TextLabel_23"]["AnchorPoint"] = Vector2.new(0, 0)
G2L["TextLabel_23"]["Rotation"] = 0
G2L["TextLabel_23"]["BackgroundColor3"] = Color3.fromRGB(163, 162, 165)
G2L["TextLabel_23"]["BackgroundTransparency"] = 1
G2L["TextLabel_23"]["BorderSizePixel"] = 0
G2L["TextLabel_23"]["Visible"] = true
G2L["TextLabel_23"]["ZIndex"] = 1
G2L["TextLabel_23"]["Text"] = "MENSAGEM DA I.A MENSAGEM DA I.A MENSAGEM DA I.A MENSAGEM DA I.A MENSAGEM DA I.A MENSAGEM DA I.A MENSAGEM DA I.A MENSAGEM DA I.A MENSAGEM DA I.A MENSAGEM DA I.A MENSAGEM DA I.A MENSAGEM DA I.A MENSAGEM DA I.A MENSAGEM DA I.A MENSAGEM DA I.A MENSAGEM DA I.A "
G2L["TextLabel_23"]["TextColor3"] = Color3.fromRGB(113, 113, 113)
G2L["TextLabel_23"]["TextSize"] = 14
G2L["TextLabel_23"]["Font"] = Enum.Font.Gotham
G2L["TextLabel_23"]["TextScaled"] = false
G2L["TextLabel_23"]["TextWrapped"] = true
G2L["TextLabel_23"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["TextLabel_23"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["TextLabel_23"]["TextTransparency"] = 0
G2L["TextLabel_23"]["TextStrokeColor3"] = Color3.fromRGB(0, 0, 0)
G2L["TextLabel_23"]["TextStrokeTransparency"] = 1
G2L["TextLabel_23"]["TextTruncate"] = Enum.TextTruncate.None
G2L["TextLabel_23"]["RichText"] = false
G2L["TextLabel_23"]["LayoutOrder"] = 0

G2L["ImageLabel_24"] = Instance.new("ImageLabel", G2L["Frame_21"])
G2L["ImageLabel_24"]["Name"] = "AIPhoto"
G2L["ImageLabel_24"]["Size"] = UDim2.new(0.1257, 0, 0.19, 0)
G2L["ImageLabel_24"]["Position"] = UDim2.new(0.012, 0, -0.24, 0)
G2L["ImageLabel_24"]["AnchorPoint"] = Vector2.new(0, 0)
G2L["ImageLabel_24"]["Rotation"] = 0
G2L["ImageLabel_24"]["BackgroundColor3"] = Color3.fromRGB(60, 60, 60)
G2L["ImageLabel_24"]["BackgroundTransparency"] = 0
G2L["ImageLabel_24"]["BorderSizePixel"] = 0
G2L["ImageLabel_24"]["Visible"] = true
G2L["ImageLabel_24"]["ZIndex"] = 1
G2L["ImageLabel_24"]["Image"] = ""
G2L["ImageLabel_24"]["ImageColor3"] = Color3.fromRGB(255, 255, 255)
G2L["ImageLabel_24"]["ImageTransparency"] = 0
G2L["ImageLabel_24"]["ScaleType"] = Enum.ScaleType.Stretch
G2L["ImageLabel_24"]["ImageRectOffset"] = Vector2.new(0, 0)
G2L["ImageLabel_24"]["ImageRectSize"] = Vector2.new(0, 0)
G2L["ImageLabel_24"]["SliceCenter"] = Rect.new(0, 0, 0, 0)
G2L["ImageLabel_24"]["SliceScale"] = 1
G2L["ImageLabel_24"]["LayoutOrder"] = 0

G2L["TextLabel_25"] = Instance.new("TextLabel", G2L["ImageLabel_24"])
G2L["TextLabel_25"]["Name"] = "NickAI"
G2L["TextLabel_25"]["Size"] = UDim2.new(6.619, 0, 1.1053, 0)
G2L["TextLabel_25"]["Position"] = UDim2.new(1.2381, 0, 0, 0)
G2L["TextLabel_25"]["AnchorPoint"] = Vector2.new(0, 0)
G2L["TextLabel_25"]["Rotation"] = 0
G2L["TextLabel_25"]["BackgroundColor3"] = Color3.fromRGB(163, 162, 165)
G2L["TextLabel_25"]["BackgroundTransparency"] = 1
G2L["TextLabel_25"]["BorderSizePixel"] = 0
G2L["TextLabel_25"]["Visible"] = true
G2L["TextLabel_25"]["ZIndex"] = 1
G2L["TextLabel_25"]["Text"] = "NINJ AI"
G2L["TextLabel_25"]["TextColor3"] = Color3.fromRGB(240, 240, 240)
G2L["TextLabel_25"]["TextSize"] = 14
G2L["TextLabel_25"]["Font"] = Enum.Font.SourceSansBold
G2L["TextLabel_25"]["TextScaled"] = false
G2L["TextLabel_25"]["TextWrapped"] = true
G2L["TextLabel_25"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["TextLabel_25"]["TextYAlignment"] = Enum.TextYAlignment.Center
G2L["TextLabel_25"]["TextTransparency"] = 0
G2L["TextLabel_25"]["TextStrokeColor3"] = Color3.fromRGB(0, 0, 0)
G2L["TextLabel_25"]["TextStrokeTransparency"] = 1
G2L["TextLabel_25"]["TextTruncate"] = Enum.TextTruncate.None
G2L["TextLabel_25"]["RichText"] = false
G2L["TextLabel_25"]["LayoutOrder"] = 0

G2L["UICorner_26"] = Instance.new("UICorner", G2L["ImageLabel_24"])
G2L["UICorner_26"]["Name"] = "UICorner22"
G2L["UICorner_26"]["CornerRadius"] = UDim.new(0, 2)

--==============================================================================
-- PARTE 2 — CONTROLADOR DA INTERFACE NINJ AI
-- Layout dinâmico, animações (TweenService) e estados enviar/parar.
-- Só interface: a IA real entra depois via NinjUI.SetResponder(fn).
--==============================================================================
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Configuração ---------------------------------------------------------------
local CFG = {
	SEND_IMAGE = "rbxassetid://94251290360710",   -- ícone de play (estado normal)
	STOP_IMAGE = "rbxassetid://81987034482699",   -- ícone mostrado enquanto a IA processa
	AI_PHOTO_IMAGE = "",                         -- ex.: "rbxassetid://123"; vazio = monograma "N" com gradiente
	AI_NAME = "NINJ AI",
	DELETE_IMAGE = "rbxassetid://6022668885",     -- item Delete do menu da aba
	RENAME_IMAGE = "rbxassetid://6034328955",     -- item Rename do menu da aba
	EDIT_IMAGE = "rbxassetid://107532273565583",  -- item Edit message (menu da sua mensagem)
	COPYMSG_IMAGE = "rbxassetid://107485544510830", -- item Copy message (menu da sua mensagem)
	NEWCHAT_IMAGE = "rbxassetid://6035173838",    -- ícone do botão New Chat
	TOGGLE_IMAGE = "rbxassetid://133729886647516", -- botão que abre/fecha o painel
	-- Ícones de ação abaixo das mensagens da IA
	COPY_IMAGE = "rbxassetid://111224245852715",
	LIKE_IMAGE = "rbxassetid://92774442572396",
	DISLIKE_IMAGE = "rbxassetid://132142104138836",
	RESTART_IMAGE = "rbxassetid://92403267975856",
	DRAG_SPEED = 0.21,                            -- suavização do arraste
	HOLD_TIME = 0.45,                            -- segurar na aba (toque/mouse) abre o menu
	PLACEHOLDER = "Pergunte algo à NINJ AI...",
	TOGGLE_KEY = Enum.KeyCode.RightControl,      -- tecla extra para abrir/fechar (PC)
	MAX_CHATS = 6,
	MAX_INPUT_CHARS = 4000,
	MAX_AI_CHARS = 20000,
}

local LAYOUT = {
	TEXT_SIZE = 14, FONT = Enum.Font.Gotham,
	PAD_X = 10, PAD_Y = 8, MIN_INNER_W = 40, MIN_BUBBLE_H = 36,
	USER_MAX = 0.72, AI_MAX = 0.92,           -- largura máx. do balão (fração do histórico)
	MAX_H_RATIO = 0.6, MAX_H_MIN = 160,       -- altura máx. do balão antes de virar rolagem interna
	PHOTO = 28, HEADER_GAP = 6, ROW_GAP = 48, TOP_PAD = 40,
	PROMPT_X = 0.1831, PROMPT_W = 0.7545, PROMPT_BOTTOM = 0.9863,
	PROMPT_MIN_H = 44, PROMPT_MAX_RATIO = 0.35, PROMPT_MAX_MIN = 96,
	PROMPT_PAD_X = 14, BTN = 32, BTN_MARGIN = 8,
	HISTORY_TOP = 0.09, HISTORY_GAP = 12,
	ACTION_H = 22, ACTION_GAP = 6, ACTION_ICON = 16, ACTION_PAD = 4,
}

local TI = {
	fast = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	base = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	out = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
	panelIn = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
	panelOut = TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
	pulse = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
	menu = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	spinLoop = TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1),
	spin = TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
	copyGreen = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
}

-- Referências (tudo vem do G2L, nada é recriado) -------------------------------
local UI = {
	gui = G2L["ScreenGui_1"], root = G2L["Frame_2"], sidebar = G2L["Frame_3"],
	container = G2L["Frame_9"], prompt = G2L["Frame_10"], box = G2L["TextBox_12"],
	btn = G2L["ImageButton_13"], newChat = G2L["TextButton_4"],
}
local TPL = { user = G2L["Frame_15"], ai = G2L["Frame_21"] } -- moldes das mensagens

-- Estado ---------------------------------------------------------------------
local S = {
	msgs = {}, order = 0, convs = {}, active = 1, job = nil, jobId = 0,
	open = false, destroyed = false, switching = false, switchId = 0,
	stick = true, hasText = false, promptTarget = LAYOUT.PROMPT_MIN_H,
	responder = nil, layoutKey = "", relayoutToken = 0,
}
local API = {}
local conns = {}
local regenerate, openMenu, closeMenu, openMsgMenu, editMessage, cancelEdit -- definidas mais abaixo

local function bind(signal, fn)
	local c = signal:Connect(fn)
	conns[#conns + 1] = c
	return c
end

-- Tween com cancelamento: nunca há dois tweens na mesma propriedade/chave ------
local tweens = setmetatable({}, { __mode = "k" })
local function stopTween(inst, key)
	local bucket = tweens[inst]
	local tw = bucket and bucket[key]
	if tw then tw:Cancel(); bucket[key] = nil end
end
local function play(inst, key, info, goal, done)
	local bucket = tweens[inst]
	if not bucket then bucket = {}; tweens[inst] = bucket end
	if bucket[key] then bucket[key]:Cancel() end
	local tw = TweenService:Create(inst, info, goal)
	bucket[key] = tw
	tw.Completed:Connect(function(state)
		if bucket[key] == tw then bucket[key] = nil end
		if done and state == Enum.PlaybackState.Completed then done() end
	end)
	tw:Play()
	return tw
end

-- Utilidades -----------------------------------------------------------------
local HUGE = 100000
local function measure(text, width)
	if text == "" then text = " " end
	local ok, size = pcall(TextService.GetTextSize, TextService, text, LAYOUT.TEXT_SIZE, LAYOUT.FONT, Vector2.new(math.max(width, 1), HUGE))
	if ok then return size end
	local perLine = math.max(1, math.floor(width / 7)) -- estimativa de segurança
	local lines = 0
	for line in (text .. "\n"):gmatch("(.-)\n") do
		lines += math.max(1, math.ceil(#line / perLine))
	end
	return Vector2.new(width, lines * (LAYOUT.TEXT_SIZE + 2))
end
local LINE_H = measure("Ag", 1000).Y

local function trim(s) return (s:match("^%s*(.-)%s*$")) end
local function truncate(s, n)
	local len = utf8.len(s)
	if not len then return s:sub(1, n) end
	if len <= n then return s end
	return s:sub(1, utf8.offset(s, n + 1) - 1)
end

-- Fade (um tween por instância) ----------------------------------------------
local function collectFade(root)
	local list = {}
	local function add(inst)
		local goal = {}
		if inst:IsA("GuiObject") and inst.BackgroundTransparency < 1 then goal.BackgroundTransparency = inst.BackgroundTransparency end
		if inst:IsA("TextLabel") or inst:IsA("TextButton") then goal.TextTransparency = inst.TextTransparency end
		if inst:IsA("ImageLabel") or inst:IsA("ImageButton") then goal.ImageTransparency = inst.ImageTransparency end
		if next(goal) then list[#list + 1] = { inst = inst, goal = goal } end
	end
	add(root)
	for _, d in ipairs(root:GetDescendants()) do add(d) end
	return list
end

--==============================================================================
-- RAIZ / PAINEL
--==============================================================================
S.restPos = UDim2.new(0.5, 0, 0.5, 0)
UI.root.Active = true
UI.root.Selectable = true

local function hiddenPos()
	local p = S.restPos
	return UDim2.new(p.X.Scale, p.X.Offset, p.Y.Scale + 1.2, p.Y.Offset)
end
UI.root.Position = hiddenPos()

local function setOpen(open)
	if S.destroyed or S.open == open then return end
	S.open = open
	if not open and closeMenu then closeMenu() end
	if open then
		UI.root.Visible = true
		play(UI.root, "pos", TI.panelIn, { Position = S.restPos })
	else
		play(UI.root, "pos", TI.panelOut, { Position = hiddenPos() }, function()
			if not S.open then UI.root.Visible = false end
		end)
	end
end

--==============================================================================
-- HISTÓRICO (ScrollingFrame + UIListLayout, fora do FramePrompt)
--==============================================================================
local hist = Instance.new("ScrollingFrame")
hist.Name = "History"
hist.BackgroundTransparency = 1
hist.BorderSizePixel = 0
hist.Position = UDim2.new(LAYOUT.PROMPT_X, 0, LAYOUT.HISTORY_TOP, 0)
hist.Size = UDim2.new(LAYOUT.PROMPT_W, 0, 0.7, 0)
hist.CanvasSize = UDim2.new(0, 0, 0, 0)
hist.AutomaticCanvasSize = Enum.AutomaticSize.Y
hist.ScrollingDirection = Enum.ScrollingDirection.Y
hist.ScrollBarThickness = 4
hist.ScrollBarImageColor3 = Color3.fromRGB(70, 70, 70)
hist.ClipsDescendants = true
hist.Parent = UI.container
UI.history = hist

local list = Instance.new("UIListLayout")
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Padding = UDim.new(0, LAYOUT.ROW_GAP)
list.Parent = hist
local histPad = Instance.new("UIPadding")
histPad.PaddingTop = UDim.new(0, LAYOUT.TOP_PAD)
histPad.PaddingBottom = UDim.new(0, 16)
histPad.Parent = hist

local function maxScroll() return math.max(0, hist.AbsoluteCanvasSize.Y - hist.AbsoluteWindowSize.Y) end
local function scrollBottom() hist.CanvasPosition = Vector2.new(0, maxScroll()) end

bind(hist:GetPropertyChangedSignal("CanvasPosition"), function()
	S.stick = (maxScroll() - hist.CanvasPosition.Y) <= 32
end)
bind(hist:GetPropertyChangedSignal("AbsoluteCanvasSize"), function() if S.stick then scrollBottom() end end)

local function updateHistorySize()
	local ch = UI.container.AbsoluteSize.Y
	local top = ch * LAYOUT.HISTORY_TOP
	local bottom = ch * LAYOUT.PROMPT_BOTTOM - UI.prompt.AbsoluteSize.Y - LAYOUT.HISTORY_GAP
	hist.Size = UDim2.new(LAYOUT.PROMPT_W, 0, 0, math.max(40, math.floor(bottom - top)))
end

--==============================================================================
-- FRAMEPROMPT (cresce para cima, âncora inferior)
--==============================================================================
local PAD_Y_PROMPT

local function setupPrompt()
	local p, box, btn = UI.prompt, UI.box, UI.btn
	p.Name = "FramePrompt"
	p.AnchorPoint = Vector2.new(0, 1)
	p.Position = UDim2.new(LAYOUT.PROMPT_X, 0, LAYOUT.PROMPT_BOTTOM, 0)
	p.Size = UDim2.new(LAYOUT.PROMPT_W, 0, 0, LAYOUT.PROMPT_MIN_H)
	p.ClipsDescendants = false

	PAD_Y_PROMPT = math.max(4, math.floor((LAYOUT.PROMPT_MIN_H - LINE_H) / 2))
	box.Text = ""
	box.PlaceholderText = CFG.PLACEHOLDER
	box.MultiLine = true
	box.TextWrapped = true
	box.ClearTextOnFocus = false
	box.ClipsDescendants = true
	box.TextXAlignment = Enum.TextXAlignment.Left
	box.TextYAlignment = Enum.TextYAlignment.Top
	box.AnchorPoint = Vector2.new(0, 0)
	box.Position = UDim2.new(0, LAYOUT.PROMPT_PAD_X, 0, PAD_Y_PROMPT)
	box.Size = UDim2.new(1, -(LAYOUT.PROMPT_PAD_X * 2 + LAYOUT.BTN + LAYOUT.BTN_MARGIN), 1, -PAD_Y_PROMPT * 2)

	btn.Parent = p
	btn.AnchorPoint = Vector2.new(0.5, 0.5)
	btn.Size = UDim2.new(0, LAYOUT.BTN, 0, LAYOUT.BTN)
	btn.Position = UDim2.new(1, -(LAYOUT.BTN_MARGIN + LAYOUT.BTN / 2), 1, -(math.floor((LAYOUT.PROMPT_MIN_H - LAYOUT.BTN) / 2) + LAYOUT.BTN / 2))
	btn.Image = CFG.SEND_IMAGE
	btn.AutoButtonColor = false
	btn.ZIndex = 2
	local sc = Instance.new("UIScale")
	sc.Name = "PressScale"
	sc.Parent = btn
	UI.btnScale = sc
end

local function promptMaxH()
	return math.max(LAYOUT.PROMPT_MAX_MIN, math.floor(UI.container.AbsoluteSize.Y * LAYOUT.PROMPT_MAX_RATIO))
end

local function updatePrompt(immediate)
	local w = UI.box.AbsoluteSize.X - 4
	if w < 10 then return end
	local text = UI.box.Text
	local h = LINE_H
	if text ~= "" then
		if text:sub(-1) == "\n" then text = text .. "A" end
		h = math.max(LINE_H, measure(text, w).Y)
	end
	local want = math.clamp(math.ceil(h) + PAD_Y_PROMPT * 2, LAYOUT.PROMPT_MIN_H, promptMaxH())
	if want == S.promptTarget and not immediate then return end
	S.promptTarget = want
	local goal = UDim2.new(LAYOUT.PROMPT_W, 0, 0, want)
	if immediate then
		stopTween(UI.prompt, "size")
		UI.prompt.Size = goal
	else
		play(UI.prompt, "size", TI.fast, { Size = goal })
	end
end

--==============================================================================
-- BOTÃO ENVIAR / PARAR
--==============================================================================
local function updateSendAppearance()
	if S.job or S.swapping then return end
	local has = UI.box.Text:find("%S") ~= nil
	if has == S.hasText then return end
	S.hasText = has
	play(UI.btn, "alpha", TI.fast, { ImageTransparency = has and 0 or 0.45 })
end

-- Troca o ícone com animação: gira 90° sumindo, troca a imagem e volta girando de -90° para 0°.
local function swapIcon(image, after)
	local btn = UI.btn
	stopTween(btn, "alpha")
	stopTween(btn, "pulse")
	S.iconToken = (S.iconToken or 0) + 1
	local token = S.iconToken
	play(btn, "spin", TI.fast, { Rotation = 90, ImageTransparency = 1 }, function()
		if token ~= S.iconToken then return end
		btn.Image = image
		btn.Rotation = -90
		play(btn, "spin", TI.base, { Rotation = 0, ImageTransparency = 0 }, function()
			if token == S.iconToken and after then after() end
		end)
	end)
end

local function setButtonState(state, instant)
	local btn = UI.btn
	if state == "processing" then
		S.swapping = true
		play(btn, "tint", TI.base, { ImageColor3 = Color3.fromRGB(255, 90, 90) })
		swapIcon(CFG.STOP_IMAGE, function()
			S.swapping = false
			if S.job then play(btn, "pulse", TI.pulse, { ImageTransparency = 0.4 }) end -- só enquanto processa
		end)
	elseif instant then
		S.iconToken = (S.iconToken or 0) + 1
		stopTween(btn, "pulse"); stopTween(btn, "spin")
		btn.Image = CFG.SEND_IMAGE
		btn.Rotation = 0
		btn.ImageTransparency = 0
		btn.ImageColor3 = Color3.new(1, 1, 1)
		S.swapping = false
		S.hasText = true
		updateSendAppearance()
	else
		S.swapping = true
		play(btn, "tint", TI.base, { ImageColor3 = Color3.new(1, 1, 1) })
		swapIcon(CFG.SEND_IMAGE, function()
			S.swapping = false
			S.hasText = true
			updateSendAppearance()
		end)
	end
end

--==============================================================================
-- MENSAGENS
--==============================================================================
local COLOR_IDLE_ICON = Color3.fromRGB(170, 170, 170)
local COLOR_GREEN = Color3.fromRGB(80, 220, 120)
local COLOR_RED = Color3.fromRGB(255, 80, 80)

local function setupTemplate(tpl, isUser)
	local label = tpl:FindFirstChild(isUser and "TextUser" or "TextAI")
	local photo = tpl:FindFirstChild(isUser and "UserPhoto" or "AIPhoto")
	local nick = photo and photo:FindFirstChild(isUser and "NickUser" or "NickAI")
	assert(label and photo and nick, "NINJ AI: hierarquia de mensagem inesperada")
	tpl.ClipsDescendants = false
	label.TextWrapped = true
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Top
	photo.AnchorPoint = Vector2.new(isUser and 1 or 0, 0)
	photo.Size = UDim2.new(0, LAYOUT.PHOTO, 0, LAYOUT.PHOTO)
	photo.Position = UDim2.new(isUser and 1 or 0, isUser and -4 or 4, 0, -(LAYOUT.PHOTO + LAYOUT.HEADER_GAP))
	nick.TextWrapped = false
	nick.TextTruncate = Enum.TextTruncate.AtEnd
	tpl.Parent = nil
	return photo, nick
end

local function setupTemplates()
	local _, userNick = setupTemplate(TPL.user, true)
	local aiPhoto, aiNick = setupTemplate(TPL.ai, false)
	aiNick.Text = CFG.AI_NAME
	if CFG.AI_PHOTO_IMAGE ~= "" then
		aiPhoto.Image = CFG.AI_PHOTO_IMAGE
	else
		aiPhoto.BackgroundColor3 = Color3.new(1, 1, 1)
		local g = G2L["UIGradient_8"]:Clone()
		g.Name = "AIPhotoGradient"
		g.Rotation = 45
		g.Parent = aiPhoto
		local mono = Instance.new("TextLabel")
		mono.Name = "Monogram"
		mono.BackgroundTransparency = 1
		mono.Size = UDim2.new(1, 0, 1, 0)
		mono.Font = Enum.Font.GothamBlack
		mono.TextSize = 16
		mono.Text = "N"
		mono.TextColor3 = Color3.new(1, 1, 1)
		mono.Parent = aiPhoto
	end
	UI.userNickTpl = userNick
end

local function currentDisplayName()
	local n = LocalPlayer.DisplayName
	if n == nil or n == "" then n = LocalPlayer.Name end
	return n
end

local function applyUserName()
	local name = currentDisplayName()
	UI.userNickTpl.Text = name
	TPL.user:SetAttribute("AccountName", LocalPlayer.Name)
	for _, m in ipairs(S.msgs) do
		if m.kind == "user" then m.nick.Text = name; m.bubble:SetAttribute("AccountName", LocalPlayer.Name) end
	end
end

local function applyUserThumb(content)
	TPL.user.UserPhoto.Image = content
	for _, m in ipairs(S.msgs) do
		if m.kind == "user" then m.photo.Image = content end
	end
end

-- Giro do botão restart enquanto a IA gera de novo
local function startSpin(btn)
	if not btn or not btn.Parent then return end
	stopTween(btn, "spin")
	btn.Rotation = 0
	play(btn, "spin", TI.spinLoop, { Rotation = 360 })
end

local function stopSpin(btn)
	if not btn or not btn.Parent then return end
	stopTween(btn, "spin")
	local r = btn.Rotation % 360
	if r < 1 or r > 359 then btn.Rotation = 0; return end
	btn.Rotation = r
	play(btn, "spin", TI.spin, { Rotation = 360 }, function() btn.Rotation = 0 end) -- termina o giro suavemente
end

-- Barra de ações (copy / like / dislike / restart) sob o balão da IA ----------
local function makeActionButton(parent, name, imageId, order)
	local b = Instance.new("ImageButton")
	b.Name = name
	b.Size = UDim2.new(0, LAYOUT.ACTION_ICON, 0, LAYOUT.ACTION_ICON)
	b.BackgroundTransparency = 1
	b.BorderSizePixel = 0
	b.Image = imageId
	b.ImageColor3 = COLOR_IDLE_ICON
	b.AutoButtonColor = false
	b.LayoutOrder = order
	b.ZIndex = 2
	b.Parent = parent
	return b
end

local function attachActionBar(msg)
	if msg.kind ~= "ai" or msg.actions then return end
	local bar = Instance.new("Frame")
	bar.Name = "ActionBar"
	bar.BackgroundTransparency = 1
	bar.BorderSizePixel = 0
	bar.Size = UDim2.new(0, LAYOUT.ACTION_ICON * 4 + LAYOUT.ACTION_PAD * 3, 0, LAYOUT.ACTION_H)
	bar.Position = UDim2.new(0, 4, 1, LAYOUT.ACTION_GAP)
	bar.ZIndex = 2
	bar.Parent = msg.row

	local layout = Instance.new("UIListLayout")
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.Padding = UDim.new(0, LAYOUT.ACTION_PAD)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = bar

	local copyBtn = makeActionButton(bar, "Copy", CFG.COPY_IMAGE, 1)
	local likeBtn = makeActionButton(bar, "Like", CFG.LIKE_IMAGE, 2)
	local dislikeBtn = makeActionButton(bar, "Dislike", CFG.DISLIKE_IMAGE, 3)
	local restartBtn = makeActionButton(bar, "Restart", CFG.RESTART_IMAGE, 4)

	msg.actions = {
		bar = bar,
		copy = copyBtn,
		like = likeBtn,
		dislike = dislikeBtn,
		restart = restartBtn,
		liked = false,
		disliked = false,
	}

	-- COPY: fica verde por um instante e volta
	bind(copyBtn.Activated, function()
		if S.destroyed or msg.thinking then return end
		local text = msg.text or ""
		pcall(function()
			if setclipboard then setclipboard(text) end
		end)
		stopTween(copyBtn, "tint")
		copyBtn.ImageColor3 = COLOR_GREEN
		play(copyBtn, "tint", TI.copyGreen, { ImageColor3 = COLOR_GREEN }, function()
			task.delay(0.55, function()
				if copyBtn.Parent then
					play(copyBtn, "tint", TI.base, { ImageColor3 = COLOR_IDLE_ICON })
				end
			end)
		end)
	end)

	-- LIKE: fica verde e permanece até clicar em dislike
	bind(likeBtn.Activated, function()
		if S.destroyed or msg.thinking then return end
		msg.actions.liked = true
		msg.actions.disliked = false
		stopTween(likeBtn, "tint")
		stopTween(dislikeBtn, "tint")
		play(likeBtn, "tint", TI.fast, { ImageColor3 = COLOR_GREEN })
		play(dislikeBtn, "tint", TI.fast, { ImageColor3 = COLOR_IDLE_ICON })
	end)

	-- DISLIKE: fica vermelho e permanece até clicar em like
	bind(dislikeBtn.Activated, function()
		if S.destroyed or msg.thinking then return end
		msg.actions.disliked = true
		msg.actions.liked = false
		stopTween(likeBtn, "tint")
		stopTween(dislikeBtn, "tint")
		play(dislikeBtn, "tint", TI.fast, { ImageColor3 = COLOR_RED })
		play(likeBtn, "tint", TI.fast, { ImageColor3 = COLOR_IDLE_ICON })
	end)

	-- RESTART: o ícone gira enquanto a resposta é gerada de novo, na mesma mensagem
	bind(restartBtn.Activated, function()
		if S.destroyed or S.switching or msg.thinking or S.job then return end
		regenerate(msg)
	end)
end

local function sizeFor(msg)
	local availW = hist.AbsoluteWindowSize.X
	if availW < 80 then return nil end
	local padX, padY = LAYOUT.PAD_X, LAYOUT.PAD_Y
	local maxOuter = math.floor(availW * (msg.kind == "user" and LAYOUT.USER_MAX or LAYOUT.AI_MAX))
	local maxInner = maxOuter - padX * 2
	local text = msg.text
	local widest = measure(text, maxInner).X
	local innerW = math.clamp(math.ceil(widest) + 4, LAYOUT.MIN_INNER_W, maxInner)
	local h = math.max(LINE_H, math.ceil(measure(text, innerW).Y))
	local maxH = math.max(LAYOUT.MAX_H_MIN, math.floor(UI.container.AbsoluteSize.Y * LAYOUT.MAX_H_RATIO))
	if h + padY * 2 > maxH then
		local sb = 8
		local lw = maxInner - sb
		return maxInner + padX * 2, maxH, lw, math.ceil(measure(text, lw).Y), true
	end
	return innerW + padX * 2, h + padY * 2, innerW, h, false
end

local function applyLayout(msg, animate)
	local bw, bh, lw, lh, scroll = sizeFor(msg)
	if not bw then return end
	local padX, padY = LAYOUT.PAD_X, LAYOUT.PAD_Y
	local label = msg.label

	if scroll and not msg.scroll then
		local sf = Instance.new("ScrollingFrame")
		sf.Name = "BodyScroll"
		sf.BackgroundTransparency = 1
		sf.BorderSizePixel = 0
		sf.ScrollBarThickness = 3
		sf.ScrollBarImageColor3 = Color3.fromRGB(70, 70, 70)
		sf.ScrollingDirection = Enum.ScrollingDirection.Y
		sf.Parent = msg.bubble
		label.Parent = sf
		msg.scroll = sf
	elseif not scroll and msg.scroll then
		label.Parent = msg.bubble
		msg.scroll:Destroy()
		msg.scroll = nil
	end

	if msg.scroll then
		msg.scroll.Position = UDim2.new(0, padX, 0, padY)
		msg.scroll.Size = UDim2.new(0, lw + 8, 1, -padY * 2)
		msg.scroll.CanvasSize = UDim2.new(0, 0, 0, lh)
		label.Position = UDim2.new(0, 0, 0, 0)
	else
		label.Position = UDim2.new(0, padX, 0, padY)
	end
	label.Size = UDim2.new(0, lw, 0, lh)
	label.Text = msg.text

	local extraH = 0
	if msg.kind == "ai" and (not msg.thinking or msg.actions) then
		extraH = LAYOUT.ACTION_H + LAYOUT.ACTION_GAP
	end

	local bubbleGoal = UDim2.new(0, bw, 0, bh)
	local rowGoal = UDim2.new(1, 0, 0, bh + extraH)
	if animate then
		play(msg.bubble, "size", TI.base, { Size = bubbleGoal })
		play(msg.row, "size", TI.base, { Size = rowGoal })
	else
		stopTween(msg.bubble, "size"); stopTween(msg.row, "size")
		msg.bubble.Size = bubbleGoal
		msg.row.Size = rowGoal
	end

	if msg.actions and msg.actions.bar then
		msg.actions.bar.Position = UDim2.new(0, 4, 0, bh + LAYOUT.ACTION_GAP)
	end
end

local function enterMessage(msg)
	local isUser = msg.kind == "user"
	local targets = collectFade(msg.bubble)
	if msg.actions and msg.actions.bar then
		for _, t in ipairs(collectFade(msg.actions.bar)) do
			targets[#targets + 1] = t
		end
	end
	for _, t in ipairs(targets) do
		local start = {}
		for k in pairs(t.goal) do start[k] = 1 end
		for k, v in pairs(start) do t.inst[k] = v end
		play(t.inst, "fade", TI.base, t.goal)
	end
	msg.bubble.Position = UDim2.new(isUser and 1 or 0, 0, 0, 12)
	play(msg.bubble, "pos", TI.base, { Position = UDim2.new(isUser and 1 or 0, 0, 0, 0) })
end

local function fadeOutRow(msg)
	local isUser = msg.kind == "user"
	local targets = collectFade(msg.bubble)
	if msg.actions and msg.actions.bar then
		for _, t in ipairs(collectFade(msg.actions.bar)) do
			targets[#targets + 1] = t
		end
	end
	for _, t in ipairs(targets) do
		local goal = {}
		for k in pairs(t.goal) do goal[k] = 1 end
		play(t.inst, "fade", TI.out, goal)
	end
	play(msg.bubble, "pos", TI.out, { Position = UDim2.new(isUser and 1 or 0, 0, 0, -8) })
	task.delay(TI.out.Time + 0.03, function()
		if msg.row.Parent then msg.row:Destroy() end
	end)
end

local function removeMessage(msg)
	for i, m in ipairs(S.msgs) do
		if m == msg then table.remove(S.msgs, i); break end
	end
	fadeOutRow(msg)
end

-- Clique direito OU segurar na SUA mensagem abre o menu (Edit message / Copy message).
local function attachUserMenu(msg)
	local b = msg.bubble
	local holdToken = 0
	bind(b.InputBegan, function(input)
		local t = input.UserInputType
		if t == Enum.UserInputType.MouseButton2 then
			openMsgMenu(msg)
		elseif t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
			holdToken += 1
			local mine = holdToken
			local start = input.Position
			task.delay(CFG.HOLD_TIME, function()
				if mine ~= holdToken or S.destroyed or not msg.row.Parent then return end
				local st = input.UserInputState
				if st == Enum.UserInputState.End or st == Enum.UserInputState.Cancel then return end
				if (input.Position - start).Magnitude > 10 then return end -- arrastando para rolar: não abre
				openMsgMenu(msg)
			end)
		end
	end)
	bind(b.InputEnded, function(input)
		local t = input.UserInputType
		if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then holdToken += 1 end
	end)
end

local function createMessage(kind, text, opts)
	opts = opts or {}
	local isUser = kind == "user"
	S.order += 1
	local row = Instance.new("Frame")
	row.Name = isUser and "UserRow" or "AIRow"
	row.BackgroundTransparency = 1
	row.BorderSizePixel = 0
	row.Size = UDim2.new(1, 0, 0, LAYOUT.MIN_BUBBLE_H)
	row.LayoutOrder = S.order
	row.ClipsDescendants = false

	local bubble = (isUser and TPL.user or TPL.ai):Clone()
	bubble.AnchorPoint = Vector2.new(isUser and 1 or 0, 0)
	bubble.Position = UDim2.new(isUser and 1 or 0, 0, 0, 0)
	bubble.Size = UDim2.new(0, 100, 0, LAYOUT.MIN_BUBBLE_H)
	bubble.Parent = row

	local photo = bubble:FindFirstChild(isUser and "UserPhoto" or "AIPhoto")
	local msg = {
		kind = kind, text = text, row = row, bubble = bubble, thinking = opts.thinking, entry = opts.entry,
		label = bubble:FindFirstChild(isUser and "TextUser" or "TextAI"),
		photo = photo, nick = photo:FindFirstChild(isUser and "NickUser" or "NickAI"),
	}
	applyLayout(msg, false)
	if isUser then attachUserMenu(msg) end
	if not isUser and not opts.thinking then
		attachActionBar(msg)
		applyLayout(msg, false) -- recalcula altura da row com a barra
	end
	if opts.forceStick then S.stick = true end
	row.Parent = hist
	S.msgs[#S.msgs + 1] = msg
	if opts.animate then enterMessage(msg) end
	if S.stick then task.defer(function() if S.stick and not S.destroyed then scrollBottom() end end) end
	return msg
end

--==============================================================================
-- CONVERSAS (abas, menu de contexto, renomear, excluir)
--==============================================================================
local COLOR_IDLE, COLOR_ACTIVE, COLOR_FLASH = Color3.fromRGB(40, 40, 40), Color3.fromRGB(58, 58, 58), Color3.fromRGB(75, 75, 75)
local RED, RED_BG = Color3.fromRGB(255, 70, 70), Color3.fromRGB(95, 35, 35)
local MAX_NAME = 14
S.chatCounter = 2

local function slotPos(slot) return UDim2.new(0, 0, 0.1404 + (slot - 1) * 0.1301, 0) end

local function styleChatButtons()
	for i, c in ipairs(S.convs) do
		if not c.deleting then
			play(c.button, "bg", TI.base, { BackgroundColor3 = (i == S.active) and COLOR_ACTIVE or COLOR_IDLE })
		end
	end
end

local function flash(inst)
	play(inst, "bg", TI.fast, { BackgroundColor3 = COLOR_FLASH }, function()
		play(inst, "bg", TI.base, { BackgroundColor3 = COLOR_IDLE })
	end)
end

local cancelJob

local function populate(index)
	S.stick = true
	for _, m in ipairs(S.convs[index].messages) do
		createMessage(m.kind, m.text, { animate = true, entry = m })
	end
	S.switching = false
	task.defer(function() if not S.destroyed then scrollBottom() end end)
end

local function switchChat(index)
	if S.destroyed or index == S.active or S.switching then return end
	if not S.convs[index] or S.convs[index].deleting then return end
	closeMenu()
	cancelEdit()
	cancelJob()
	S.active = index
	styleChatButtons()
	S.switchId += 1
	local id = S.switchId
	local old = S.msgs
	S.msgs = {}
	S.switching = true
	for _, m in ipairs(old) do fadeOutRow(m) end
	if #old == 0 then
		populate(index)
	else
		task.delay(TI.out.Time + 0.06, function()
			if id ~= S.switchId or S.destroyed then return end
			populate(index)
		end)
	end
end

-- Exclui uma conversa: aba fica vermelha -> aba e mensagens somem (transparência) -> tudo é destruído.
local function deleteChat(conv)
	if S.destroyed or S.switching or conv.deleting then return end
	local btn = conv.button

	-- Último chat: não existe "zero chats"; ele é apenas esvaziado.
	if #S.convs == 1 then
		cancelJob()
		cancelEdit()
		conv.messages = {}
		local old = S.msgs
		S.msgs = {}
		for _, m in ipairs(old) do fadeOutRow(m) end
		play(btn, "bg", TI.fast, { BackgroundColor3 = RED_BG }, function()
			play(btn, "bg", TI.base, { BackgroundColor3 = COLOR_ACTIVE })
		end)
		return
	end

	conv.deleting = true
	local wasActive = S.convs[S.active] == conv
	if wasActive then
		cancelJob()
		cancelEdit()
		S.switching = true
		local old = S.msgs
		S.msgs = {}
		for _, m in ipairs(old) do fadeOutRow(m) end
	end

	play(btn, "bg", TI.fast, { BackgroundColor3 = RED_BG })
	play(btn, "txt", TI.fast, { TextColor3 = RED }, function()
		play(btn, "fade", TI.base, { BackgroundTransparency = 1, TextTransparency = 1 }, function()
			if S.destroyed then return end
			local cur = S.convs[S.active]
			local idx = table.find(S.convs, conv)
			if idx then table.remove(S.convs, idx) end
			btn:Destroy()
			for i, c in ipairs(S.convs) do
				play(c.button, "slot", TI.base, { Position = slotPos(i) })
			end
			if wasActive then
				S.active = math.clamp(idx or 1, 1, #S.convs)
				styleChatButtons()
				populate(S.active)
			else
				S.active = table.find(S.convs, cur) or 1
			end
		end)
	end)
end

-- Renomear: um TextBox aparece sobre a aba; Enter ou perder o foco confirma.
local function startRename(conv)
	local btn = conv.button
	if conv.renaming or conv.deleting then return end
	conv.renaming = true
	local box = Instance.new("TextBox")
	box.Name = "RenameBox"
	box.AnchorPoint = Vector2.new(0.5, 0.5)
	box.Position = UDim2.new(0.5, 0, 0.5, 0)
	box.Size = UDim2.new(1, -8, 1, -8)
	box.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
	box.BorderSizePixel = 0
	box.FontFace = btn.FontFace
	box.TextSize = btn.TextSize
	box.TextColor3 = Color3.fromRGB(240, 240, 240)
	box.Text = btn.Text
	box.ClearTextOnFocus = false
	box.TextWrapped = false
	box.ClipsDescendants = true
	box.ZIndex = 5
	local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0, 6); bc.Parent = box
	box.BackgroundTransparency = 1
	box.TextTransparency = 1
	box.Parent = btn
	play(box, "fade", TI.base, { BackgroundTransparency = 0, TextTransparency = 0 })
	task.defer(function() if box.Parent then box:CaptureFocus() end end)

	local cn, fl
	cn = box:GetPropertyChangedSignal("Text"):Connect(function()
		local len = utf8.len(box.Text)
		if len and len > MAX_NAME then box.Text = truncate(box.Text, MAX_NAME) end
	end)
	fl = box.FocusLost:Connect(function()
		cn:Disconnect(); fl:Disconnect()
		conv.renaming = false
		local name = trim(box.Text)
		if name ~= "" then conv.name = name; btn.Text = name end
		play(box, "fade", TI.out, { BackgroundTransparency = 1, TextTransparency = 1 }, function() box:Destroy() end)
	end)
end

-- Menus de contexto (aba e mensagem). Expandem como o FramePrompt: Size animado + fade.
-- Cada item = botão vazio + ícone à esquerda + TextLabel ao lado do ícone.
-- (UIPadding no botão deslocaria também o ícone, por isso o texto fica num TextLabel próprio.)
local MENUS = {}
local MENU_TAB, MENU_MSG
local ITEM_H, MENU_PAD, ICON_X, TEXT_X = 26, 4, 8, 30

local function makeMenuItem(parent, name, text, icon, y)
	local b = Instance.new("TextButton")
	b.Name = name
	b.Text = ""
	b.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
	b.BackgroundTransparency = 1
	b.BorderSizePixel = 0
	b.AutoButtonColor = false
	b.Position = UDim2.new(0, MENU_PAD, 0, MENU_PAD + y)
	b.Size = UDim2.new(1, -MENU_PAD * 2, 0, ITEM_H)
	b.ZIndex = 21
	local cr = Instance.new("UICorner"); cr.CornerRadius = UDim.new(0, 6); cr.Parent = b

	local ic = Instance.new("ImageLabel")
	ic.Name = "Icon"
	ic.AnchorPoint = Vector2.new(0, 0.5)
	ic.Size = UDim2.new(0, 14, 0, 14)
	ic.Position = UDim2.new(0, ICON_X - MENU_PAD, 0.5, 0) -- esquerda
	ic.BackgroundTransparency = 1
	ic.Image = icon
	ic.ZIndex = 22
	ic.Parent = b

	local lbl = Instance.new("TextLabel")
	lbl.Name = "Label"
	lbl.BackgroundTransparency = 1
	lbl.Position = UDim2.new(0, TEXT_X - MENU_PAD, 0, 0)
	lbl.Size = UDim2.new(1, -(TEXT_X - MENU_PAD) - 4, 1, 0)
	lbl.Font = Enum.Font.Gotham
	lbl.TextSize = 13
	lbl.Text = text
	lbl.TextColor3 = Color3.fromRGB(225, 225, 225)
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.TextTruncate = Enum.TextTruncate.AtEnd
	lbl.ZIndex = 22
	lbl.Parent = b

	bind(b.MouseEnter, function() play(b, "bg", TI.fast, { BackgroundTransparency = 0 }) end)
	bind(b.MouseLeave, function() play(b, "bg", TI.fast, { BackgroundTransparency = 1 }) end)
	b.Parent = parent
	return b, ic, lbl
end

local function buildMenu(name, width, defs)
	local M = { width = width, height = ITEM_H * #defs + MENU_PAD * 2, open = false, token = 0, fade = {}, items = {}, ctx = nil }

	local f = Instance.new("Frame")
	f.Name = name
	f.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
	f.BorderSizePixel = 0
	f.ClipsDescendants = true
	f.Size = UDim2.new(0, width, 0, 0)
	f.Visible = false
	f.ZIndex = 20
	local fc = Instance.new("UICorner"); fc.CornerRadius = UDim.new(0, 8); fc.Parent = f
	local st = Instance.new("UIStroke"); st.Color = Color3.fromRGB(60, 60, 60); st.Thickness = 1; st.Parent = f
	M.fade[#M.fade + 1] = { f, "BackgroundTransparency" }
	M.fade[#M.fade + 1] = { st, "Transparency" }

	for i, d in ipairs(defs) do
		local btn, ic, lbl = makeMenuItem(f, d.name, d.text, d.icon, (i - 1) * ITEM_H)
		M.items[d.name] = { button = btn, icon = ic, label = lbl }
		M.fade[#M.fade + 1] = { lbl, "TextTransparency" }
		M.fade[#M.fade + 1] = { ic, "ImageTransparency" }
	end
	f.Parent = UI.root

	-- captura o clique fora do menu para fechá-lo
	local catcher = Instance.new("TextButton")
	catcher.Name = name .. "Catcher"
	catcher.BackgroundTransparency = 1
	catcher.Text = ""
	catcher.AutoButtonColor = false
	catcher.Size = UDim2.new(1, 0, 1, 0)
	catcher.ZIndex = 19
	catcher.Visible = false
	catcher.Parent = UI.root
	M.frame, M.catcher = f, catcher

	function M.close()
		if not M.open then return end
		M.open = false
		M.token += 1
		local token = M.token
		catcher.Visible = false
		for _, e in ipairs(M.fade) do play(e[1], "fade", TI.out, { [e[2]] = 1 }) end
		play(f, "size", TI.out, { Size = UDim2.new(0, width, 0, 0) }, function()
			if token == M.token then f.Visible = false end
		end)
	end

	-- x, y em coordenadas do Frame1; sempre mantido dentro do painel
	function M.openAt(x, y)
		for _, o in ipairs(MENUS) do if o ~= M then o.close() end end
		local rs = UI.root.AbsoluteSize
		x = math.clamp(x, 4, math.max(4, rs.X - width - 4))
		y = math.clamp(y, 4, math.max(4, rs.Y - M.height - 4))
		M.token += 1
		M.open = true
		f.Position = UDim2.new(0, x, 0, y)
		f.Size = UDim2.new(0, width, 0, 0)
		f.Visible = true
		catcher.Visible = true
		for _, it in pairs(M.items) do it.icon.ImageColor3 = Color3.new(1, 1, 1) end
		for _, e in ipairs(M.fade) do
			e[1][e[2]] = 1
			play(e[1], "fade", TI.menu, { [e[2]] = 0 })
		end
		play(f, "size", TI.menu, { Size = UDim2.new(0, width, 0, M.height) })
	end

	bind(catcher.InputBegan, function(input)
		local t = input.UserInputType
		if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.MouseButton2 or t == Enum.UserInputType.Touch then
			M.close()
		end
	end)
	MENUS[#MENUS + 1] = M
	return M
end

function closeMenu()
	for _, M in ipairs(MENUS) do M.close() end
end

function openMenu(conv) -- menu da aba
	if S.destroyed or S.switching or conv.deleting or conv.renaming or not MENU_TAB then return end
	local rp, tb = UI.root.AbsolutePosition, conv.button
	MENU_TAB.ctx = conv
	MENU_TAB.openAt(tb.AbsolutePosition.X - rp.X + tb.AbsoluteSize.X * 0.5, tb.AbsolutePosition.Y - rp.Y + tb.AbsoluteSize.Y * 0.8)
end

function openMsgMenu(msg) -- menu da mensagem do usuário
	if S.destroyed or S.switching or not MENU_MSG or not msg.row.Parent then return end
	local rp, b = UI.root.AbsolutePosition, msg.bubble
	MENU_MSG.ctx = msg
	MENU_MSG.openAt(b.AbsolutePosition.X - rp.X + b.AbsoluteSize.X - MENU_MSG.width, b.AbsolutePosition.Y - rp.Y + b.AbsoluteSize.Y * 0.5)
end

local function setupMenu()
	MENU_TAB = buildMenu("TabMenu", 100, {
		{ name = "Rename", text = "Rename", icon = CFG.RENAME_IMAGE },
		{ name = "Delete", text = "Delete", icon = CFG.DELETE_IMAGE },
	})
	MENU_MSG = buildMenu("MessageMenu", 128, {
		{ name = "Edit", text = "Edit message", icon = CFG.EDIT_IMAGE },
		{ name = "Copy", text = "Copy message", icon = CFG.COPYMSG_IMAGE },
	})

	bind(MENU_TAB.items.Rename.button.Activated, function()
		local c = MENU_TAB.ctx
		closeMenu()
		if c then startRename(c) end
	end)
	bind(MENU_TAB.items.Delete.button.Activated, function()
		local c = MENU_TAB.ctx
		play(MENU_TAB.items.Delete.icon, "tint", TI.fast, { ImageColor3 = RED }, function()
			closeMenu()
			if c then deleteChat(c) end
		end)
	end)

	bind(MENU_MSG.items.Edit.button.Activated, function()
		local m = MENU_MSG.ctx
		closeMenu()
		if m then editMessage(m) end
	end)
	bind(MENU_MSG.items.Copy.button.Activated, function()
		local m = MENU_MSG.ctx
		if m then pcall(function() if setclipboard then setclipboard(m.text or "") end end) end
		play(MENU_MSG.items.Copy.icon, "tint", TI.fast, { ImageColor3 = COLOR_GREEN }, function()
			task.delay(0.25, closeMenu)
		end)
	end)
end

-- Clique abre o chat; botão direito OU segurar a aba abre o menu.
local function bindConv(conv)
	local btn = conv.button
	local holdToken = 0
	bind(btn.Activated, function()
		if conv.menuFired then conv.menuFired = false; return end
		if conv.deleting or conv.renaming then return end
		local i = table.find(S.convs, conv)
		if i then switchChat(i) end
	end)
	bind(btn.InputBegan, function(input)
		local t = input.UserInputType
		if t == Enum.UserInputType.MouseButton2 then
			openMenu(conv)
		elseif t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
			conv.menuFired = false
			holdToken += 1
			local mine = holdToken
			task.delay(CFG.HOLD_TIME, function()
				if mine ~= holdToken or S.destroyed or conv.deleting then return end
				local state = input.UserInputState
				if state == Enum.UserInputState.End or state == Enum.UserInputState.Cancel then return end
				conv.menuFired = true
				openMenu(conv)
			end)
		end
	end)
	bind(btn.InputEnded, function(input)
		local t = input.UserInputType
		if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then holdToken += 1 end
	end)
end

local function styleChatText(btn)
	btn.TextXAlignment = Enum.TextXAlignment.Center -- texto das abas no centro
	btn.TextTruncate = Enum.TextTruncate.AtEnd
	local pad = Instance.new("UIPadding")
	pad.Name = "ChatPadding"
	pad.PaddingLeft = UDim.new(0, 4)
	pad.PaddingRight = UDim.new(0, 4)
	pad.Parent = btn
end

local function newChat()
	if S.switching then return end
	if #S.convs >= CFG.MAX_CHATS then flash(UI.newChat); return end
	closeMenu()
	S.chatCounter += 1
	local n = S.chatCounter
	local btn = TPL.chat:Clone()
	btn.Name = "Chat " .. n
	btn.Text = "Chat" .. n
	btn.Position = slotPos(#S.convs + 1)
	btn.BackgroundColor3 = COLOR_IDLE
	btn.Parent = UI.sidebar
	local conv = { button = btn, messages = {}, name = "Chat" .. n }
	S.convs[#S.convs + 1] = conv
	bindConv(conv)
	local a, b = btn.BackgroundTransparency, btn.TextTransparency
	btn.BackgroundTransparency, btn.TextTransparency = 1, 1
	play(btn, "fade", TI.base, { BackgroundTransparency = a, TextTransparency = b })
	switchChat(#S.convs)
end

local function initChats()
	-- New Chat: só "New", com o ícone à esquerda do texto (texto centralizado)
	local nb = UI.newChat
	nb.Text = "New"
	nb.TextXAlignment = Enum.TextXAlignment.Center
	local icon = Instance.new("ImageLabel")
	icon.Name = "NewChatIcon"
	icon.AnchorPoint = Vector2.new(0, 0.5)
	icon.Size = UDim2.new(0, 16, 0, 16)
	icon.BackgroundTransparency = 1
	icon.Image = CFG.NEWCHAT_IMAGE
	icon.ZIndex = 2
	icon.Parent = nb
	local function placeIcon()
		local w = nb.TextBounds.X
		if w <= 0 then w = 28 end
		icon.Position = UDim2.new(0.5, -(w / 2) - 6 - 16, 0.5, 0)
	end
	placeIcon()
	bind(nb:GetPropertyChangedSignal("TextBounds"), placeIcon)

	styleChatText(G2L["TextButton_5"])
	styleChatText(G2L["TextButton_6"])
	TPL.chat = G2L["TextButton_6"]:Clone() -- molde para novas abas

	S.convs[1] = { button = G2L["TextButton_5"], messages = {}, name = "Chat1" }
	S.convs[2] = { button = G2L["TextButton_6"], messages = {}, name = "Chat2" }
	for _, c in ipairs(S.convs) do bindConv(c) end
	bind(UI.newChat.Activated, newChat)
	setupMenu()
end

--==============================================================================
-- PROCESSAMENTO (enviar / parar)
--==============================================================================
function cancelJob()
	local job = S.job
	if not job then return end
	job.cancelled = true
	S.job = nil
	for _, th in ipairs({ job.thread, job.dots }) do
		if th and coroutine.status(th) ~= "dead" then pcall(task.cancel, th) end
	end
	local ph = job.placeholder
	if ph then
		if job.regen then
			-- cancelou a regeneração: a resposta anterior volta
			ph.thinking = false
			ph.text = job.regen.prevText
			if ph.row.Parent then
				ph.label.TextTransparency = 1
				applyLayout(ph, true)
				play(ph.label, "fade", TI.base, { TextTransparency = 0 })
			end
			if ph.actions then stopSpin(ph.actions.restart) end
		else
			removeMessage(ph) -- resposta cancelada nunca entra no histórico
		end
	end
	setButtonState("idle")
end

local function finishJob(job, text)
	if job.cancelled or S.job ~= job then return end
	S.job = nil
	text = truncate(text, CFG.MAX_AI_CHARS)
	local ph = job.placeholder
	if job.regen then
		if ph.entry then ph.entry.text = text end -- troca o texto salvo da mesma resposta
	else
		local conv = S.convs[S.active]
		local entry = { kind = "ai", text = text }
		conv.messages[#conv.messages + 1] = entry
		ph.entry = entry
	end
	ph.thinking = false
	ph.text = text
	ph.label.TextTransparency = 1
	attachActionBar(ph)
	applyLayout(ph, true)
	play(ph.label, "fade", TI.base, { TextTransparency = 0 })
	if ph.actions then
		stopSpin(ph.actions.restart)
		if job.regen then -- nova resposta: zera curtir/não curtir
			ph.actions.liked, ph.actions.disliked = false, false
			play(ph.actions.like, "tint", TI.fast, { ImageColor3 = COLOR_IDLE_ICON })
			play(ph.actions.dislike, "tint", TI.fast, { ImageColor3 = COLOR_IDLE_ICON })
		end
	end
	setButtonState("idle")
end

-- regenMsg (opcional): mensagem da IA que será gerada de novo no mesmo lugar.
local function startJob(text, regenMsg)
	S.jobId += 1
	local job = { id = S.jobId, cancelled = false }
	S.job = job
	setButtonState("processing")
	if regenMsg then
		job.regen = { prevText = regenMsg.text }
		job.placeholder = regenMsg
		regenMsg.thinking = true
		regenMsg.text = "Pensando..."
		regenMsg.label.TextTransparency = 1
		applyLayout(regenMsg, true)
		play(regenMsg.label, "fade", TI.base, { TextTransparency = 0 })
		if regenMsg.actions then startSpin(regenMsg.actions.restart) end
	else
		job.placeholder = createMessage("ai", "Pensando...", { animate = true, thinking = true })
	end
	job.dots = task.spawn(function()
		local n = 0
		while S.job == job and not job.cancelled do
			n = n % 3 + 1
			local ph = job.placeholder
			if ph and ph.label.Parent then ph.label.Text = "Pensando" .. string.rep(".", n) end
			task.wait(0.4)
		end
	end)
	job.thread = task.spawn(function()
		local ok, result = pcall(S.responder, text, job)
		if job.cancelled or S.job ~= job then return end
		if not ok then
			result = "[Erro] Falha interna ao processar a mensagem: " .. tostring(result)
		elseif type(result) ~= "string" or not result:find("%S") then
			result = "(resposta vazia)"
		end
		finishJob(job, trim(result))
	end)
end

-- Gera de novo a resposta de uma mensagem da IA, usando o prompt do usuário imediatamente acima.
function regenerate(msg)
	if S.job or S.destroyed or S.switching or msg.thinking or not msg.row.Parent then return end
	local userText
	for i, m in ipairs(S.msgs) do
		if m == msg then
			for j = i - 1, 1, -1 do
				if S.msgs[j].kind == "user" then
					userText = S.msgs[j].text
					break
				end
			end
			break
		end
	end
	if not userText or userText == "" then return end
	startJob(userText, msg)
end

-- Editar mensagem: o texto vai para o prompt; ao enviar, a mensagem é atualizada,
-- tudo que veio depois dela é removido e a IA responde de novo.
local function setEditVisual(msg, on)
	local st = msg.bubble:FindFirstChild("EditStroke")
	if on then
		if not st then
			st = Instance.new("UIStroke")
			st.Name = "EditStroke"
			st.Color = Color3.fromRGB(150, 110, 255)
			st.Thickness = 1
			st.Transparency = 1
			st.Parent = msg.bubble
		end
		play(st, "fade", TI.base, { Transparency = 0 })
	elseif st then
		play(st, "fade", TI.base, { Transparency = 1 }, function() st:Destroy() end)
	end
end

function cancelEdit()
	local m = S.editing
	if not m then return end
	S.editing = nil
	if m.row.Parent then setEditVisual(m, false) end
	UI.box.Text = ""
end

function editMessage(msg)
	if S.destroyed or S.switching or S.job or not msg.row.Parent then return end
	if S.editing and S.editing ~= msg and S.editing.row.Parent then setEditVisual(S.editing, false) end
	S.editing = msg
	setEditVisual(msg, true)
	UI.box.Text = msg.text
	task.defer(function() if S.editing == msg and not S.destroyed then UI.box:CaptureFocus() end end)
end

local function commitEdit(text)
	local msg = S.editing
	S.editing = nil
	if not msg or not msg.row.Parent then return false end
	local idx
	for i, m in ipairs(S.msgs) do
		if m == msg then idx = i; break end
	end
	if not idx then return false end
	setEditVisual(msg, false)
	local conv = S.convs[S.active]
	local tail = {}
	for i = idx + 1, #S.msgs do tail[#tail + 1] = S.msgs[i] end
	for _, m in ipairs(tail) do removeMessage(m) end
	if msg.entry then
		local eidx = table.find(conv.messages, msg.entry)
		if eidx then
			for k = #conv.messages, eidx + 1, -1 do table.remove(conv.messages, k) end
		end
		msg.entry.text = text
	end
	msg.text = text
	msg.label.TextTransparency = 1
	applyLayout(msg, true)
	play(msg.label, "fade", TI.base, { TextTransparency = 0 })
	UI.box.Text = ""
	startJob(text)
	return true
end

local function sendMessage(text)
	if S.editing and commitEdit(text) then return end
	local conv = S.convs[S.active]
	local entry = { kind = "user", text = text }
	conv.messages[#conv.messages + 1] = entry
	createMessage("user", text, { animate = true, forceStick = true, entry = entry })
	UI.box.Text = ""
	if not UserInputService.TouchEnabled then
		task.defer(function() if not S.destroyed then UI.box:CaptureFocus() end end)
	end
	startJob(text)
end

local function onAction()
	if S.destroyed or S.switching then return end
	if S.job then cancelJob(); return end
	local text = trim(UI.box.Text)
	if text == "" then
		if S.editing then cancelEdit(); return end -- enviar vazio durante edição cancela a edição
		play(UI.btnScale, "press", TI.fast, { Scale = 0.8 }, function() play(UI.btnScale, "press", TI.base, { Scale = 1 }) end)
		return
	end
	sendMessage(truncate(text, CFG.MAX_INPUT_CHARS))
end

-- Responder de TESTE
S.responder = function(text, job)
	task.wait(1.4)
	return "Interface pronta. A IA baseada em regras ainda não está conectada — esta é só uma resposta de teste.\n\nVocê escreveu:\n" .. text
end

--==============================================================================
-- INICIALIZAÇÃO E EVENTOS
--==============================================================================
setupPrompt()
setupTemplates()
UI.userNickTpl.Text = currentDisplayName()

initChats()

bind(UI.btn.Activated, onAction)
bind(UI.btn.MouseButton1Down, function() play(UI.btnScale, "press", TI.fast, { Scale = 0.86 }) end)
bind(UI.btn.MouseButton1Up, function() play(UI.btnScale, "press", TI.base, { Scale = 1 }) end)
bind(UI.btn.MouseLeave, function() play(UI.btnScale, "press", TI.base, { Scale = 1 }) end)

local clamping = false
bind(UI.box:GetPropertyChangedSignal("Text"), function()
	if clamping then return end
	local t = UI.box.Text
	if #t > CFG.MAX_INPUT_CHARS then
		local cut = truncate(t, CFG.MAX_INPUT_CHARS)
		if cut ~= t then clamping = true; UI.box.Text = cut; clamping = false end
	end
	updatePrompt(false)
	updateSendAppearance()
end)
bind(UI.prompt:GetPropertyChangedSignal("AbsoluteSize"), updateHistorySize)

local function scheduleRelayout()
	S.relayoutToken += 1
	local token = S.relayoutToken
	task.delay(0.06, function()
		if token ~= S.relayoutToken or S.destroyed then return end
		for _, m in ipairs(S.msgs) do if m.row.Parent then applyLayout(m, false) end end
		updatePrompt(true)
	end)
end
local function checkViewport()
	local key = math.floor(hist.AbsoluteWindowSize.X) .. "x" .. math.floor(UI.container.AbsoluteSize.Y)
	if key ~= S.layoutKey then S.layoutKey = key; scheduleRelayout() end
end
bind(hist:GetPropertyChangedSignal("AbsoluteSize"), function()
	if S.stick then scrollBottom() end
	checkViewport()
end)
bind(UI.container:GetPropertyChangedSignal("AbsoluteSize"), function()
	updateHistorySize()
	checkViewport()
end)

bind(LocalPlayer:GetPropertyChangedSignal("DisplayName"), applyUserName)

bind(UserInputService.InputBegan, function(input, processed)
	if not processed and input.KeyCode == CFG.TOGGLE_KEY then setOpen(not S.open) end
end)
do
	local tb = Instance.new("ImageButton")
	tb.Name = "TogglePanel"
	tb.Size = UDim2.new(0, 40, 0, 40)
	tb.Position = UDim2.new(1, -52, 0, 10)
	tb.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	tb.BorderSizePixel = 0
	tb.Image = CFG.TOGGLE_IMAGE
	tb.ZIndex = 10
	local tc = Instance.new("UICorner"); tc.CornerRadius = UDim.new(0, 8); tc.Parent = tb
	tb.Parent = UI.gui
	bind(tb.Activated, function() setOpen(not S.open) end)
end

-- Arrastar
local drag = { active = false, input = nil, start = nil, startPos = nil }
local dragInfo = TweenInfo.new(CFG.DRAG_SPEED, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function dragUpdate(input)
	local delta = input.Position - drag.start
	local vp, size, ap, sp = UI.gui.AbsoluteSize, UI.root.AbsoluteSize, UI.root.AnchorPoint, drag.startPos
	local cx = sp.X.Scale * vp.X + sp.X.Offset + delta.X
	local cy = sp.Y.Scale * vp.Y + sp.Y.Offset + delta.Y
	cx = math.clamp(cx, 40 - size.X + size.X * ap.X, vp.X - 40 + size.X * ap.X)
	cy = math.clamp(cy, 40 - size.Y + size.Y * ap.Y, vp.Y - 40 + size.Y * ap.Y)
	local newPos = UDim2.new(sp.X.Scale, cx - sp.X.Scale * vp.X, sp.Y.Scale, cy - sp.Y.Scale * vp.Y)
	S.restPos = newPos
	play(UI.root, "pos", dragInfo, { Position = newPos })
end

local function dragBegin(input)
	if drag.active or not S.open then return end
	if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
	drag.active = true
	drag.start = input.Position
	drag.startPos = UI.root.Position
	local c
	c = input.Changed:Connect(function()
		if input.UserInputState == Enum.UserInputState.End then
			drag.active = false
			if c then c:Disconnect() end
		end
	end)
end

local bar = Instance.new("Frame")
bar.Name = "DragBar"
bar.BackgroundTransparency = 1
bar.BorderSizePixel = 0
bar.Active = true
bar.Position = UDim2.new(0.2, 0, 0, 0)
bar.Size = UDim2.new(0.8, 0, LAYOUT.HISTORY_TOP, 0)
bar.ZIndex = 3
bar.Parent = UI.root

for _, handle in ipairs({ bar, UI.sidebar }) do
	bind(handle.InputBegan, dragBegin)
	bind(handle.InputChanged, function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			drag.input = input
		end
	end)
end
bind(UserInputService.InputChanged, function(input)
	if input == drag.input and drag.active then dragUpdate(input) end
end)

do
	local t0 = os.clock()
	while UI.container.AbsoluteSize.Y <= 0 and os.clock() - t0 < 3 do task.wait() end
end
updateHistorySize()
updatePrompt(true)
S.layoutKey = math.floor(hist.AbsoluteWindowSize.X) .. "x" .. math.floor(UI.container.AbsoluteSize.Y)
styleChatButtons()
setButtonState("idle", true)
applyUserName()
setOpen(true)

task.spawn(function()
	for attempt = 1, 5 do
		if S.destroyed then return end
		local ok, content, ready = pcall(Players.GetUserThumbnailAsync, Players, LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
		if ok and type(content) == "string" and content ~= "" then
			applyUserThumb(content)
			if ready then return end
		end
		task.wait(2 * attempt)
	end
end)

--==============================================================================
-- TÍTULO ANIMADO: NINJ AI -> WELCOME <nome> -> MADE BY -> BIEL -> BLUS -> BAH (em loop)
-- Letra por letra: surge transparente por baixo e sobe suavemente até a posição original.
-- Cada palavra fica 3s depois de completa. O gradiente de cada letra corre para a direita.
--==============================================================================
do
	local TITLE = { SIZE = 20, RISE = 10, STAGGER = 0.08, APPEAR = 0.4, HOLD = 3, SWEEP = 2.2, SWEEP_LAG = 0.12, MARGIN = 24 }

	local tpl = G2L["TextLabel_7"] -- título original vira molde das letras (mesma fonte/cor/gradiente)
	tpl.Visible = false
	local kp = G2L["UIGradient_8"].Color.Keypoints
	local c0, c1 = kp[1].Value, kp[#kp].Value
	-- paleta "vai e volta" (c0 -> c1 -> c0): o gradiente corre sem emenda quando repete
	local palette = ColorSequence.new({
		ColorSequenceKeypoint.new(0, c0), ColorSequenceKeypoint.new(0.5, c1), ColorSequenceKeypoint.new(1, c0),
	})

	-- área entre a lateral (sidebar) e a borda direita do painel; o texto fica no meio dela
	local holder = Instance.new("Frame")
	holder.Name = "TitleHolder"
	holder.BackgroundTransparency = 1
	holder.BorderSizePixel = 0
	holder.Parent = UI.root

	local function placeTitle()
		local sbRight = math.max(0, UI.sidebar.AbsolutePosition.X + UI.sidebar.AbsoluteSize.X - UI.root.AbsolutePosition.X)
		holder.Position = UDim2.new(0, sbRight, 0, 0)
		holder.Size = UDim2.new(1, -sbRight, LAYOUT.HISTORY_TOP, 0)
	end
	placeTitle()
	bind(UI.root:GetPropertyChangedSignal("AbsoluteSize"), placeTitle)

	local word = Instance.new("Frame")
	word.Name = "TitleWord"
	word.BackgroundTransparency = 1
	word.BorderSizePixel = 0
	word.AnchorPoint = Vector2.new(0.5, 0.5)
	word.Position = UDim2.new(0.5, 0, 0.5, 0)
	word.Size = UDim2.new(0, 0, 1, 0)
	word.AutomaticSize = Enum.AutomaticSize.X
	word.Parent = holder
	local lay = Instance.new("UIListLayout")
	lay.FillDirection = Enum.FillDirection.Horizontal
	lay.HorizontalAlignment = Enum.HorizontalAlignment.Center
	lay.VerticalAlignment = Enum.VerticalAlignment.Center
	lay.SortOrder = Enum.SortOrder.LayoutOrder
	lay.Parent = word

	local current -- { slots, tweens, labels }

	local function clearWord()
		if not current then return end
		for _, tw in ipairs(current.tweens) do tw:Cancel() end
		for _, sl in ipairs(current.slots) do sl:Destroy() end
		current = nil
	end

	-- monta as letras da palavra e dispara a animação; devolve quantas letras animam
	local function buildWord(text)
		clearWord()
		local avail = math.max(60, holder.AbsoluteSize.X - TITLE.MARGIN)
		local size = TITLE.SIZE
		local ok, m = pcall(TextService.GetTextSize, TextService, text, size, Enum.Font.GothamBlack, Vector2.new(10000, 200))
		if ok and m.X > avail then size = math.max(8, math.floor(size * avail / m.X)) end -- nomes longos encolhem

		current = { slots = {}, tweens = {}, labels = {} }
		local count, order = 0, 0
		for _, cp in utf8.codes(text) do
			order += 1
			local ch = utf8.char(cp)
			local slot = Instance.new("Frame")
			slot.Name = "LetterSlot"
			slot.BackgroundTransparency = 1
			slot.BorderSizePixel = 0
			slot.LayoutOrder = order
			if ch == " " then
				slot.Size = UDim2.new(0, math.floor(size * 0.35), 1, 0)
			else
				count += 1
				slot.Size = UDim2.new(0, 0, 1, 0)
				slot.AutomaticSize = Enum.AutomaticSize.X
				local lb = tpl:Clone()
				lb.Name = "Letter"
				lb.Visible = true
				lb.Text = ch
				lb.TextScaled = false
				lb.TextWrapped = false
				lb.TextSize = size
				lb.AnchorPoint = Vector2.new(0, 0)
				lb.Size = UDim2.new(0, 0, 1, 0)
				lb.AutomaticSize = Enum.AutomaticSize.X
				lb.Position = UDim2.new(0, 0, 0, TITLE.RISE) -- começa embaixo
				lb.TextTransparency = 1                      -- e transparente
				lb.Parent = slot

				local g = lb:FindFirstChildOfClass("UIGradient")
				if g then
					g.Color = palette
					g.Rotation = 0
					g.Offset = Vector2.new(-1, 0)
					local sweep = TweenService:Create(g, TweenInfo.new(TITLE.SWEEP, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false, (count - 1) * TITLE.SWEEP_LAG), { Offset = Vector2.new(1, 0) })
					current.tweens[#current.tweens + 1] = sweep
					sweep:Play()
				end

				local rise = TweenService:Create(lb, TweenInfo.new(TITLE.APPEAR, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, (count - 1) * TITLE.STAGGER), {
					TextTransparency = 0, Position = UDim2.new(0, 0, 0, 0),
				})
				current.tweens[#current.tweens + 1] = rise
				current.labels[#current.labels + 1] = lb
				rise:Play()
			end
			slot.Parent = word
			current.slots[#current.slots + 1] = slot
		end
		return count
	end

	local function titleWords()
		return { "NINJ AI", "WELCOME " .. string.upper(currentDisplayName()), "MADE BY", "BIEL", "BLUS", "BAH" }
	end

	task.spawn(function()
		local i = 0
		while not S.destroyed do
			if not S.open then
				task.wait(0.25) -- painel fechado: não começa palavra nova
			else
				local words = titleWords()
				i = i % #words + 1
				local n = buildWord(words[i])
				task.wait((n - 1) * TITLE.STAGGER + TITLE.APPEAR + TITLE.HOLD) -- animação completa + 3s
				if S.destroyed then return end
				if current then -- saída rápida antes da próxima palavra
					for _, lb in ipairs(current.labels) do
						TweenService:Create(lb, TI.out, { TextTransparency = 1, Position = UDim2.new(0, 0, 0, -6) }):Play()
					end
				end
				task.wait(TI.out.Time + 0.05)
			end
		end
	end)
end

--==============================================================================
-- API
--==============================================================================
function API.Open() setOpen(true) end
function API.Close() setOpen(false) end
function API.Toggle() setOpen(not S.open) end
function API.IsProcessing() return S.job ~= nil end
function API.SetResponder(fn)
	assert(type(fn) == "function", "SetResponder espera uma função")
	S.responder = fn
end
function API.Destroy()
	if S.destroyed then return end
	S.destroyed = true
	cancelJob()
	for _, c in ipairs(conns) do c:Disconnect() end
	table.clear(conns)
	if UI.gui then UI.gui:Destroy() end
	if shared.NinjUI == API then shared.NinjUI = nil end
end
API.ScreenGui = UI.gui

shared.NinjUI = API
return API
