local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function createGui()
-- 1. Create the ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BottomButtonsUI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

-- 2. Create a Container Frame (Centered at the bottom)
local container = Instance.new("Frame")
container.Name = "Container"
container.Size = UDim2.new(1, 0, 0.15, 0) -- Takes up bottom 15% of screen
container.Position = UDim2.new(0, 0, 0.85, 0)
container.BackgroundTransparency = 1 -- Invisible container
container.Parent = screenGui

-- 3. Add Layout (Horizontal List)
local layout = Instance.new("UIListLayout")
layout.Parent = container
layout.FillDirection = Enum.FillDirection.Horizontal
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Padding = UDim.new(0, 20) -- Space between buttons

-- 4. Create Buttons A, B, and C
local buttonLabels = {"A", "B", "C"}

for _, label in ipairs(buttonLabels) do
local btn = Instance.new("TextButton")
btn.Name = "Button" .. label
btn.Parent = container
btn.Size = UDim2.new(0, 100, 0, 60)
btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
btn.Text = label
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.TextSize = 30
btn.Font = Enum.Font.GothamBold

  -- Add rounded corners for aesthetics
  local corners = Instance.new("UICorner")
  corners.CornerRadius = UDim.new(0, 8)
  corners.Parent = btn
end
end

createGui()
