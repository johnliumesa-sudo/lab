if not script.Parent:IsA("Part") then
    warn("ProximityPlotScript must be placed inside a Part! Current Parent: " .. script.Parent.ClassName)
    return
end

local plot = script.Parent
local status = plot:WaitForChild("Status")

-- Create the ProximityPrompt
local prompt = Instance.new("ProximityPrompt")
prompt.ObjectText = "Farm Plot"
prompt.ActionText = "Plant"
prompt.HoldDuration = 0.5 -- How long the key must be held
prompt.KeyboardKeyCode = Enum.KeyCode.E -- Default interaction key
prompt.MaxActivationDistance = 10 -- Range
prompt.RequiresLineOfSight = false
prompt.Parent = plot

-- Configuration
local CropData = {
["Tomato"] = {
Cost = 5,
BaseSellValue = 15,
BaseDelay = 3,
Color = Color3.fromRGB(255, 0, 0)
},
["Corn"] = {
Cost = 50,
BaseSellValue = 120,
BaseDelay = 5,
Color = Color3.fromRGB(255, 255, 0)
}
}

local currentSelectedCrop = "Tomato" -- Default crop

local function updatePromptState()
    if status.Value == "Empty" then
	local data = CropData[currentSelectedCrop]
	prompt.ActionText = "Plant " .. currentSelectedCrop .. " ($" .. data.Cost .. ")"
	prompt.Enabled = true
    else
	-- Disable prompt while growing to prevent double planting
	prompt.Enabled = false
    end
end

local function onTriggered(player)
    if status.Value ~= "Empty" then return end

    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then return end

    local cash = leaderstats:FindFirstChild("Cash")
    local data = CropData[currentSelectedCrop]

    if cash and cash.Value >= data.Cost then
	-- Transaction
	cash.Value -= data.Cost

	-- Visual Feedback
	status.Value = "Growing"
	local originalColor = plot.Color
	plot.Color = data.Color
	plot.Material = Enum.Material.Plastic

	-- Growth Phase
	task.wait(data.BaseDelay)

	-- Harvest/Sell Phase
	cash.Value += data.BaseSellValue

	-- Reset
	plot.Color = originalColor
	plot.Material = Enum.Material.Grass
	status.Value = "Empty"
    else
	-- Optional: Feedback for insufficient funds
	warn(player.Name .. " cannot afford " .. currentSelectedCrop)
    end
end

-- Initialize state
updatePromptState()

-- Listen for status changes to re-enable prompt after harvest
status.Changed:Connect(updatePromptState)

-- Connect Prompt Trigger
prompt.Triggered:Connect(onTriggered)
