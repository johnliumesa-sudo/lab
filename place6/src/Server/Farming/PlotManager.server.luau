local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- Create folder for plots
local plotsFolder = Instance.new("Folder")
plotsFolder.Name = "FarmPlots"
plotsFolder.Parent = Workspace

-- Define plot template
local plotTemplate = Instance.new("Part")
plotTemplate.Name = "Plot"
plotTemplate.Size = Vector3.new(8, 1, 8)
plotTemplate.Anchored = true
plotTemplate.Material = Enum.Material.Ground -- Dirt by default
plotTemplate.Color = Color3.fromRGB(109, 87, 60) -- Dirt Brown

-- Floor represents the terrain under the plot
local plotFloor = Instance.new("Part")
plotFloor.Name = "Floor"
plotFloor.Size = Vector3.new(10, 30, 10) -- Very deep base to fill mountain gaps
plotFloor.Anchored = true
plotFloor.Material = Enum.Material.Grass
plotFloor.Color = Color3.fromRGB(75, 150, 75)

-- Add Configuration values
local status = Instance.new("StringValue")
status.Name = "Status"
status.Value = "Empty"
status.Parent = plotTemplate

-- Grid Settings
local gridSize = 30 -- 30x30 = 900 plots
local spacing = 10

-- Center the map
local totalWidth = gridSize * spacing
local startPos = Vector3.new(-totalWidth/2, 0, -totalWidth/2)

local function getBiomeData(x, z)
-- 1. Mountain Ring Logic (Edges)
-- If we are within the first 4 or last 4 rows/cols, we are in the mountains
if x <= 4 or x >= gridSize - 3 or z <= 4 or z >= gridSize - 3 then
local height = 40 + math.random(0, 5) -- High elevation
local material = Enum.Material.Rock
local color = Color3.fromRGB(99, 95, 98) -- Stone Grey
return height, material, color
end

-- 2. Valley Logic (Center)
-- Calculate distance from the center X line
local centerX = gridSize / 2
local distFromCenter = math.abs(x - centerX)

-- Parabolic height for valley shape (Gentle slope in the middle)
local height = (distFromCenter / centerX) ^ 2 * 15

-- Biome Logic
local material = Enum.Material.Grass
local color = Color3.fromRGB(75, 150, 75) -- Green

-- Desert Logic (Further from center, but before mountains)
if distFromCenter > 8 then
    material = Enum.Material.Sand
    color = Color3.fromRGB(236, 219, 137) -- Sand Yellow
elseif distFromCenter > 6 then
    -- Transition
    material = Enum.Material.LeafyGrass
    color = Color3.fromRGB(120, 160, 80)
end

return height, material, color
end

local function spawnGrid()
for x = 1, gridSize do
for z = 1, gridSize do
local height, biomeMat, biomeColor = getBiomeData(x, z)

        local finalPos = startPos + Vector3.new((x - 1) * spacing, height, (z - 1) * spacing)

        -- Create Plot (The farmable surface)
        local newPlot = plotTemplate:Clone()
        newPlot.Position = finalPos
        newPlot.Parent = plotsFolder

        -- Create Floor (The terrain underneath)
        -- Shifted down so the top aligns with the plot, but extends downwards to form the hill
        local newFloor = plotFloor:Clone()
        newFloor.Position = finalPos - Vector3.new(0, 15, 0) -- Shift down half height (30/2)
        newFloor.Material = biomeMat
        newFloor.Color = biomeColor
        newFloor.Parent = newPlot

        -- Inject logic script
        local logicScript = script.Parent:FindFirstChild("ProximityPlotScript")
        if logicScript then
            local cloneScript = logicScript:Clone()
            cloneScript.Parent = newPlot
            cloneScript.Enabled = true
        end
    end
end
end

spawnGrid()
