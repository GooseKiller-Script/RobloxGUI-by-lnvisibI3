
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local MENU_COLOR = Color3.fromRGB(0, 0, 0)
local MENU_STROKE_COLOR = Color3.fromRGB(255, 255, 255)
local BUTTON_BG_COLOR = Color3.fromRGB(0, 0, 0)       
local BUTTON_TEXT_COLOR = Color3.fromRGB(255, 255, 255)
local BUTTON_HOVER_COLOR = Color3.fromRGB(40, 40, 40) 
local CLOSE_BUTTON_COLOR = Color3.fromRGB(255, 255, 255)
local CLOSE_BUTTON_HOVER_COLOR = Color3.fromRGB(200, 200, 200)

local SG = Instance.new("ScreenGui", game.CoreGui)
SG.ResetOnSpawn = false

local function MakeDraggable(obj, handle)
	handle = handle or obj
	local dragging, dragStart, startPos
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = obj.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

local Icon = Instance.new("TextButton", SG)
Icon.Size = UDim2.new(0, 90, 0, 50)
Icon.Position = UDim2.new(1, -100, 0.5, -25)
Icon.BackgroundColor3 = MENU_COLOR
Icon.BackgroundTransparency = 0
Icon.Text = "Roblox GUI"
Icon.TextColor3 = BUTTON_TEXT_COLOR
Icon.Font = Enum.Font.GothamBold
Icon.TextScaled = true
Instance.new("UICorner", Icon).CornerRadius = UDim.new(0, 8)
MakeDraggable(Icon)


local Menu = Instance.new("Frame", SG)
Menu.Size = UDim2.new(0, 360, 0, 460)
Menu.Position = UDim2.new(0.5, -180, 0.5, -230)
Menu.BackgroundColor3 = MENU_COLOR
Menu.BackgroundTransparency = 0
Menu.BorderSizePixel = 0
Instance.new("UICorner", Menu).CornerRadius = UDim.new(0, 18)
Menu.Visible = false
MakeDraggable(Menu)

local stroke = Instance.new("UIStroke", Menu)
stroke.Color = MENU_STROKE_COLOR
stroke.Thickness = 3
stroke.Transparency = 0

local Title = Instance.new("TextLabel", Menu)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Position = UDim2.new(0, 0, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "Roblox GUI"
Title.TextColor3 = MENU_STROKE_COLOR
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.TextStrokeTransparency = 0.3

local CloseBtn = Instance.new("TextButton", Menu)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -38, 0, 8)
CloseBtn.BackgroundColor3 = CLOSE_BUTTON_COLOR
CloseBtn.Text = "✕"
CloseBtn.TextScaled = true
CloseBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.AutoButtonColor = false
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseEnter:Connect(function()
	CloseBtn.BackgroundColor3 = CLOSE_BUTTON_HOVER_COLOR
end)
CloseBtn.MouseLeave:Connect(function()
	CloseBtn.BackgroundColor3 = CLOSE_BUTTON_COLOR
end)

CloseBtn.MouseButton1Click:Connect(function()
	Menu.Visible = false
	Icon.Visible = true
end)

local ScrollFrame = Instance.new("ScrollingFrame", Menu)
ScrollFrame.Size = UDim2.new(1, -30, 1, -70)
ScrollFrame.Position = UDim2.new(0, 15, 0, 55)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
ScrollFrame.ScrollBarThickness = 10
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.Always
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

local UIList = Instance.new("UIListLayout", ScrollFrame)
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 15)

local function CreateButton(parent, text, callback)
	local b = Instance.new("TextButton", parent)
	b.Size = UDim2.new(1, 0, 0, 50)
	b.BackgroundColor3 = BUTTON_BG_COLOR
	b.BorderSizePixel = 0
	b.Text = text
	b.TextColor3 = BUTTON_TEXT_COLOR
	b.TextScaled = true
	b.Font = Enum.Font.GothamSemibold
	b.AutoButtonColor = false
	b.ClipsDescendants = true
	b.LayoutOrder = #parent:GetChildren()

	local stroke = Instance.new("UIStroke", b)
	stroke.Color = MENU_STROKE_COLOR
	stroke.Thickness = 2
	stroke.Transparency = 0

	b.MouseEnter:Connect(function()
		b.BackgroundColor3 = BUTTON_HOVER_COLOR
		stroke.Transparency = 0
	end)
	b.MouseLeave:Connect(function()
		b.BackgroundColor3 = BUTTON_BG_COLOR
		stroke.Transparency = 0
	end)

	b.MouseButton1Click:Connect(function()
		callback(b)
	end)
	return b
end

CreateButton(ScrollFrame, "AntiCheat Detector", function()
	print("Anti-cheat detector is currently empty")
end)

CreateButton(ScrollFrame, "Infinite Yield FE", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

CreateButton(ScrollFrame, "Dex Explorer", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua"))()
end)

CreateButton(ScrollFrame, "lnvisibI3-GUI", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/GooseKiller-Script/GK-GUI-By-GooseKiller-Universal-Roblox-Script/refs/heads/main/GUI.lua"))()
end)

CreateButton(ScrollFrame, "Developer Console", function()
	StarterGui:SetCore("DevConsoleVisible", true)
end)

CreateButton(ScrollFrame, "FPS Booster", function()
	local Lighting = game:GetService("Lighting")
	Lighting.GlobalShadows = false
	Lighting.ShadowSoftness = 0
	pcall(function()
		Lighting.Bloom.Enabled = false
		Lighting.DepthOfField.Enabled = false
		Lighting.AmbientOcclusionEnabled = false
		Lighting.ColorCorrection.Enabled = false
		Lighting.Sunset.Enabled = false
	end)
	game.Workspace.FogEnd = 100
	game.Workspace.FogStart = 0
	for _, light in pairs(game.Workspace:GetDescendants()) do
		if light:IsA("PointLight") or light:IsA("SpotLight") or light:IsA("SurfaceLight") then
			light.Enabled = false
		end
	end
	for _, particle in pairs(game.Workspace:GetDescendants()) do
		if particle:IsA("ParticleEmitter") or particle:IsA("Trail") or particle:IsA("Beam") then
			particle.Enabled = false
		end
	end
	for _, sound in pairs(game.Workspace:GetDescendants()) do
		if sound:IsA("Sound") then
			sound.Playing = false
			sound.Volume = 0
		end
    end
end)

CreateButton(ScrollFrame, "Close All GUI", function()
	for _, gui in pairs(game.CoreGui:GetChildren()) do
		if gui:IsA("ScreenGui") then
			gui:Destroy()
		end
    end
end)
Icon.MouseButton1Click:Connect(function()
	Menu.Visible = true
	Icon.Visible = false
end)
