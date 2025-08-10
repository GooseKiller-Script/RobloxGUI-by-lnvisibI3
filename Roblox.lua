local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")

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

local function split(input, delimiter)
    local result = {}
    for match in (input..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

local isSpying = false
local remoteSpyLogWindow = nil

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

CreateButton(ScrollFrame, "Place Scanner", function()
	local isScanning = false
	local scanWindow = nil
	local scanProgressLabel = nil
	local scanLogScrollFrame = nil
	
	if not isScanning then
		isScanning = true
		scanWindow = Instance.new("ScreenGui", game.CoreGui)
		scanWindow.Name = "PlaceScannerWindow"
		scanWindow.ResetOnSpawn = false

		local frame = Instance.new("Frame", scanWindow)
		frame.Size = UDim2.new(0, 500, 0, 400)
		frame.Position = UDim2.new(0.5, -250, 0.5, -200)
		frame.BackgroundColor3 = MENU_COLOR
		Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
		MakeDraggable(frame)

		local title = Instance.new("TextLabel", frame)
		title.Size = UDim2.new(1, 0, 0, 30)
		title.Text = "Place Scanner"
		title.TextColor3 = MENU_STROKE_COLOR
		title.BackgroundTransparency = 1
		title.Font = Enum.Font.GothamBold

		local closeBtn = Instance.new("TextButton", frame)
		closeBtn.Size = UDim2.new(0, 30, 0, 30)
		closeBtn.Position = UDim2.new(1, -35, 0, 0)
		closeBtn.Text = "✕"
		closeBtn.BackgroundColor3 = CLOSE_BUTTON_COLOR
		closeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
		closeBtn.Font = Enum.Font.GothamBold
		closeBtn.MouseButton1Click:Connect(function()
			isScanning = false
			scanWindow:Destroy()
			scanWindow = nil
		end)

		scanProgressLabel = Instance.new("TextLabel", frame)
		scanProgressLabel.Size = UDim2.new(1, -20, 0, 20)
		scanProgressLabel.Position = UDim2.new(0, 10, 0, 40)
		scanProgressLabel.Text = "Scanning: 0/0"
		scanProgressLabel.TextColor3 = Color3.new(1, 1, 1)
		scanProgressLabel.BackgroundTransparency = 1
		scanProgressLabel.Font = Enum.Font.GothamSemibold

		scanLogScrollFrame = Instance.new("ScrollingFrame", frame)
		scanLogScrollFrame.Size = UDim2.new(1, -20, 1, -80)
		scanLogScrollFrame.Position = UDim2.new(0, 10, 0, 70)
		scanLogScrollFrame.BackgroundTransparency = 1
		scanLogScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
		scanLogScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
		scanLogScrollFrame.ScrollBarThickness = 8

		local logList = Instance.new("UIListLayout", scanLogScrollFrame)
		logList.SortOrder = Enum.SortOrder.LayoutOrder
		logList.Padding = UDim.new(0, 5)

		local function addLogEntry(text, color)
			local entry = Instance.new("TextLabel", scanLogScrollFrame)
			entry.Size = UDim2.new(1, 0, 0, 20)
			entry.TextXAlignment = Enum.TextXAlignment.Left
			entry.TextYAlignment = Enum.TextYAlignment.Top
			entry.BackgroundTransparency = 1
			entry.TextColor3 = color or Color3.new(1, 1, 1)
			entry.TextSize = 14
			entry.Text = text
			entry.TextWrapped = true

			local textSize = TextService:GetTextSize(text, entry.TextSize, entry.Font, Vector2.new(scanLogScrollFrame.AbsoluteSize.X, 100000))
			entry.Size = UDim2.new(1, 0, 0, textSize.Y + 5)
			scanLogScrollFrame.CanvasSize = UDim2.new(0, 0, 0, scanLogScrollFrame.CanvasSize.Y.Offset + entry.Size.Y.Offset)
			scanLogScrollFrame.CanvasPosition = Vector2.new(0, scanLogScrollFrame.CanvasSize.Y.Offset)
		end

		task.spawn(function()
			local descendants = game:GetDescendants()
			local totalDescendants = #descendants
			local scannedCount = 0
			
			addLogEntry("Scanning started...", Color3.fromRGB(150, 255, 150))
			
			for _, descendant in ipairs(descendants) do
				if not isScanning then break end
				scannedCount = scannedCount + 1
				scanProgressLabel.Text = string.format("Scanning: %d/%d", scannedCount, totalDescendants)

				if descendant:IsA("Script") or descendant:IsA("LocalScript") then
					local success, sourceCode = pcall(function() return descendant.Source end)
					if success and sourceCode and #sourceCode > 0 then
						local lines = split(sourceCode, "\n")
						for i, line in ipairs(lines) do
							if line:match("require%(%d+%)") then
								addLogEntry("• Found potential backdoor in: " .. descendant:GetFullName(), Color3.fromRGB(255, 100, 100))
							end
							if line:match("getfenv") or line:match("setfenv") then
								addLogEntry("• Found environment manipulations in: " .. descendant:GetFullName(), Color3.fromRGB(255, 255, 100))
							end
							if line:match("RemoteFunction") or line:match("RemoteEvent") then
								addLogEntry("• Found remote object in: " .. descendant:GetFullName(), Color3.fromRGB(100, 255, 255))
							end
						end
					end
				end
				RunService.Heartbeat:Wait()
			end

			if isScanning then
				addLogEntry("Scanning completed.", Color3.fromRGB(150, 255, 150))
				isScanning = false
			end
		end)
	else
		if scanWindow then
			isScanning = false
			scanWindow:Destroy()
			scanWindow = nil
		end
	end
end)

CreateButton(ScrollFrame, "Remote Spy", function()
	if not isSpying then
		isSpying = true
		local logWindow = Instance.new("ScreenGui", game.CoreGui)
		logWindow.Name = "RemoteSpyLogWindow"
		logWindow.ResetOnSpawn = false
		remoteSpyLogWindow = logWindow

		local frame = Instance.new("Frame", logWindow)
		frame.Size = UDim2.new(0, 500, 0, 400)
		frame.Position = UDim2.new(0.5, -250, 0.5, -200)
		frame.BackgroundColor3 = MENU_COLOR
		Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
		MakeDraggable(frame)

		local title = Instance.new("TextLabel", frame)
		title.Size = UDim2.new(1, 0, 0, 30)
		title.Text = "Remote Spy Logs"
		title.TextColor3 = MENU_STROKE_COLOR
		title.BackgroundTransparency = 1
		title.Font = Enum.Font.GothamBold

		local closeBtn = Instance.new("TextButton", frame)
		closeBtn.Size = UDim2.new(0, 30, 0, 30)
		closeBtn.Position = UDim2.new(1, -35, 0, 0)
		closeBtn.Text = "✕"
		closeBtn.BackgroundColor3 = CLOSE_BUTTON_COLOR
		closeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
		closeBtn.Font = Enum.Font.GothamBold
		closeBtn.MouseButton1Click:Connect(function()
			isSpying = false
			logWindow:Destroy()
			remoteSpyLogWindow = nil
		end)

		local scrollFrame = Instance.new("ScrollingFrame", frame)
		scrollFrame.Size = UDim2.new(1, -20, 1, -50)
		scrollFrame.Position = UDim2.new(0, 10, 0, 40)
		scrollFrame.BackgroundTransparency = 1
		scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
		scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
		scrollFrame.ScrollBarThickness = 8

		local logList = Instance.new("UIListLayout", scrollFrame)
		logList.SortOrder = Enum.SortOrder.LayoutOrder
		logList.Padding = UDim.new(0, 5)

		local function addLogEntry(eventType, eventName, args)
			local argsStrings = {}
			for _, v in ipairs(args) do
				table.insert(argsStrings, tostring(v))
			end
			local entryText = string.format("[%s] %s (%s): %s", os.date("%H:%M:%S"), eventType, eventName, table.concat(argsStrings, ", "))
			local entry = Instance.new("TextLabel", scrollFrame)
			entry.Size = UDim2.new(1, 0, 0, 20)
			entry.TextXAlignment = Enum.TextXAlignment.Left
			entry.TextYAlignment = Enum.TextYAlignment.Top
			entry.BackgroundTransparency = 1
			entry.TextColor3 = Color3.new(1, 1, 1)
			entry.TextSize = 14
			entry.Text = entryText
			entry.TextWrapped = true

			local textSize = TextService:GetTextSize(entryText, entry.TextSize, entry.Font, Vector2.new(scrollFrame.AbsoluteSize.X, 100000))
			entry.Size = UDim2.new(1, 0, 0, textSize.Y + 5)

			scrollFrame.CanvasSize = UDim2.new(0, 0, 0, scrollFrame.CanvasSize.Y.Offset + entry.Size.Y.Offset)
			scrollFrame.CanvasPosition = Vector2.new(0, scrollFrame.CanvasSize.Y.Offset)
		end

		local function hookRemote(remote)
			local oldFireServer = remote.FireServer
			remote.FireServer = function(...)
				addLogEntry("FireServer", remote.Name, {...})
				return oldFireServer(remote, ...)
			end

			local oldInvokeServer = remote.InvokeServer
			remote.InvokeServer = function(...)
				addLogEntry("InvokeServer", remote.Name, {...})
				return oldInvokeServer(remote, ...)
			end
		end

		for _, remote in ipairs(game:GetDescendants()) do
			if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
				hookRemote(remote)
			end
		end

	else
		isSpying = false
		if remoteSpyLogWindow then
			remoteSpyLogWindow:Destroy()
			remoteSpyLogWindow = nil
		end
	end
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
    
