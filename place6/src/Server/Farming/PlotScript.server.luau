local plot = script.Parent
local clickDetector = plot:WaitForChild("ClickDetector")
local status = plot:WaitForChild("Status")

-- Crop Configuration (As defined in design doc)
local CropData = {
["Tomato"] = {
Cost = 5,
BaseSellValue = 15,
BaseDelay = 3,
Color = Color3.fromRGB(255, 0, 0) -- Red
},
["Corn"] = {
Cost = 50,
BaseSellValue = 120,
BaseDelay = 5,
Color = Color3.fromRGB(255, 255, 0) -- Yellow
},
["Blueberry"] = {
Cost = 150,
BaseSellValue = 400,
BaseDelay = 8,
Color = Color3.fromRGB(0, 0, 255) -- Blue
}
}

-- Default selected crop (could be stored in player data later)
local currentSelectedCrop = "Tomato"

local function getLandModifier()
-- In the future, check if this plot is on "Barren" or "Fertile" land
-- For now, default to 1.0
return 1.0
end

local function plantCrop(player)
if status.Value ~= "Empty" then return end

  local leaderstats = player:FindFirstChild("leaderstats")
  if not leaderstats then return end
  
  local cash = leaderstats:FindFirstChild("Cash")
  local data = CropData[currentSelectedCrop]
  
  if cash and cash.Value >= data.Cost then
      -- Deduct Cost
      cash.Value -= data.Cost
      
      -- Start Growth
      status.Value = "Growing"
      local originalColor = plot.Color
      
      -- Visual Indicator of growth (Change color to crop color)
      plot.Color = data.Color
      plot.Material = Enum.Material.Plastic -- Look synthetic while growing?
      
      -- Calculate time based on land quality
      local landModifier = getLandModifier()
      local finalDelay = data.BaseDelay / landModifier
      
      -- Wait for growth
      task.wait(finalDelay)
      
      -- Auto-Sell Logic
      local sellPrice = math.floor(data.BaseSellValue * landModifier)
      cash.Value += sellPrice
      
      -- Reset Plot
      plot.Color = originalColor
      plot.Material = Enum.Material.Grass
      status.Value = "Empty"
      
      -- Feedback
      print(player.Name .. " harvested " .. currentSelectedCrop .. " for $" .. sellPrice)
  else
      print("Not enough cash to plant " .. currentSelectedCrop)
  end
end

clickDetector.MouseClick:Connect(plantCrop)
