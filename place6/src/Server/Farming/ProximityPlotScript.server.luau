-- Guard Clause
if not script.Parent:IsA("Part") then
warn("ProximityPlotScript must be placed inside a Part!")
return
end

local plot = script.Parent
local status = plot:WaitForChild("Status")

-- Create ProximityPrompt
local prompt = Instance.new("ProximityPrompt")
prompt.HoldDuration = 0.5
prompt.KeyboardKeyCode = Enum.KeyCode.E
prompt.MaxActivationDistance = 12
prompt.RequiresLineOfSight = false
prompt.Parent = plot

-- Create BillboardGui
local billboard = Instance.new("BillboardGui")
billboard.Name = "InfoUI"
billboard.Size = UDim2.new(0, 200, 0, 100)
billboard.StudsOffset = Vector3.new(0, 4, 0)
billboard.AlwaysOnTop = true
billboard.MaxDistance = 15
billboard.Parent = plot

local nameLabel = Instance.new("TextLabel")
nameLabel.Name = "NameLabel"
nameLabel.Size = UDim2.new(1, 0, 0.6, 0)
nameLabel.BackgroundTransparency = 1
nameLabel.TextColor3 = Color3.new(1, 1, 1)
nameLabel.TextStrokeTransparency = 0
nameLabel.TextSize = 24
nameLabel.Font = Enum.Font.GothamBold
nameLabel.Text = "Crop"
nameLabel.Parent = billboard

local priceLabel = Instance.new("TextLabel")
priceLabel.Name = "PriceLabel"
priceLabel.Size = UDim2.new(1, 0, 0.4, 0)
priceLabel.Position = UDim2.new(0, 0, 0.6, 0)
priceLabel.BackgroundTransparency = 1
priceLabel.TextColor3 = Color3.fromRGB(85, 255, 127)
priceLabel.TextStrokeTransparency = 0
priceLabel.TextSize = 18
priceLabel.Font = Enum.Font.Gotham
priceLabel.Text = "$0"
priceLabel.Parent = billboard

-- Expanded Configuration with MeshIds (Replace 0 with actual asset IDs)
local CropData = {
["Tomato"] = { Cost = 5, BaseSellValue = 15, BaseDelay = 3, Color = Color3.fromRGB(255, 80, 80), Icon = "🍅", MeshId = "rbxassetid://1180778084" },
["Corn"] = { Cost = 50, BaseSellValue = 120, BaseDelay = 5, Color = Color3.fromRGB(255, 255, 100), Icon = "🌽", MeshId = "rbxassetid://4690085178" },
["Carrot"] = { Cost = 100, BaseSellValue = 250, BaseDelay = 6, Color = Color3.fromRGB(255, 170, 0), Icon = "🥕", MeshId = "rbxassetid://13581709876" },
["Blueberry"] = { Cost = 150, BaseSellValue = 400, BaseDelay = 8, Color = Color3.fromRGB(80, 80, 255), Icon = "🫐", MeshId = "rbxassetid://18243359587" },
["Wheat"] = { Cost = 300, BaseSellValue = 750, BaseDelay = 10, Color = Color3.fromRGB(245, 222, 179), Icon = "🌾", MeshId = "rbxassetid://7063928864" },
["Pumpkin"] = { Cost = 500, BaseSellValue = 1300, BaseDelay = 15, Color = Color3.fromRGB(255, 117, 24), Icon = "🎃", MeshId = "rbxassetid://1050943947" },
["Potato"] = { Cost = 1000, BaseSellValue = 2800, BaseDelay = 20, Color = Color3.fromRGB(139, 69, 19), Icon = "🥔", MeshId = "rbxassetid://477543051" },
["Watermelon"] = { Cost = 2500, BaseSellValue = 7000, BaseDelay = 30, Color = Color3.fromRGB(60, 179, 113), Icon = "🍉", MeshId = "rbxassetid://677827629" }
}

-- Mesh Visual Part setup
local visualPart = Instance.new("Part")
visualPart.Name = "CropVisual"
visualPart.Size = Vector3.new(1, 1, 1)
visualPart.CanCollide = false
visualPart.Anchored = true
visualPart.Transparency = 1 -- Hidden by default
visualPart.Position = plot.Position + Vector3.new(0, 1.5, 0)
visualPart.Parent = plot

local specialMesh = Instance.new("SpecialMesh")
specialMesh.MeshType = Enum.MeshType.FileMesh
specialMesh.Parent = visualPart

local function getRandomCrop()
local keys = {}
for key, _ in pairs(CropData) do
table.insert(keys, key)
end
return keys[math.random(1, #keys)]
end

local function updatePromptState(fixedCrop)
if status.Value == "Empty" then
local data = CropData[fixedCrop]

    -- Update UI
    nameLabel.Text = data.Icon .. " " .. fixedCrop
    priceLabel.Text = "$" .. data.Cost
    billboard.Enabled = true

    -- Update Prompt
    prompt.ActionText = "Plant"
    prompt.ObjectText = fixedCrop
    prompt.Enabled = true
    
    -- Reset Visuals
    visualPart.Transparency = 1
else
    -- Hide UI and Prompt while growing
    billboard.Enabled = false 
    prompt.Enabled = false
    
    -- Show Visual
    visualPart.Transparency = 0
end
end

local function onTriggered(player, fixedCrop)
if status.Value ~= "Empty" then return end

local leaderstats = player:FindFirstChild("leaderstats")
if not leaderstats then return end

local cash = leaderstats:FindFirstChild("Cash")
local data = CropData[fixedCrop]

if cash and cash.Value >= data.Cost then
    -- Transaction
    cash.Value -= data.Cost

    -- Visual Feedback
    status.Value = "Growing"
    
    -- Update Mesh Data
    specialMesh.MeshId = data.MeshId
    visualPart.Color = data.Color -- Optional tinting
    
    updatePromptState(fixedCrop)

    -- Growth Phase
    task.wait(data.BaseDelay)

    -- Harvest/Sell Phase
    cash.Value += data.BaseSellValue
    print(player.Name .. " harvested " .. data.Icon .. " for $" .. data.BaseSellValue)

    -- Reset Plot State
    status.Value = "Empty"

    updatePromptState(fixedCrop)
else
    warn(player.Name .. " cannot afford " .. fixedCrop)
end
end

-- 1. Assign the crop type ONCE
local assignedCrop = getRandomCrop()

-- 2. Initialize
updatePromptState(assignedCrop)

-- 3. Connections
status.Changed:Connect(function()
updatePromptState(assignedCrop)
end)

prompt.Triggered:Connect(function(player)
onTriggered(player, assignedCrop)
end)
