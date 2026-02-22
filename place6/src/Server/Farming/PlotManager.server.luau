local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local plotsFolder = Instance.new("Folder")
plotsFolder.Name = "FarmPlots"
plotsFolder.Parent = Workspace

local environmentFolder = Instance.new("Folder")
environmentFolder.Name = "Environment"
environmentFolder.Parent = Workspace

local plotTemplate = Instance.new("Part")
plotTemplate.Name = "Plot"
plotTemplate.Size = Vector3.new(8, 1, 8)
plotTemplate.Anchored = true
plotTemplate.Material = Enum.Material.Ground
plotTemplate.Color = Color3.fromRGB(109, 87, 60)

local plotFloor = Instance.new("Part")
plotFloor.Name = "Floor"
plotFloor.Size = Vector3.new(10, 30, 10)
plotFloor.Anchored = true
plotFloor.Material = Enum.Material.Grass
plotFloor.Color = Color3.fromRGB(75, 150, 75)

local status = Instance.new("StringValue")
status.Name = "Status"
status.Value = "Empty"
status.Parent = plotTemplate

local gridSize = 30
local spacing = 10

local totalWidth = gridSize * spacing
local startPos = Vector3.new(-totalWidth/2, 0, -totalWidth/2)

local function getBiomeData(x, z)
local isMountain = false
if x <= 4 or x >= gridSize - 3 or z <= 4 or z >= gridSize - 3 then
isMountain = true
local height = 40 + math.random(0, 15)
local material = Enum.Material.Rock
local color = Color3.fromRGB(99, 95, 98)
return height, material, color, isMountain
end

local centerX = gridSize / 2
local distFromCenter = math.abs(x - centerX)
local height = (distFromCenter / centerX) ^ 2 * 15

local material = Enum.Material.Grass
local color = Color3.fromRGB(75, 150, 75)

if distFromCenter > 8 then
    material = Enum.Material.Sand
    color = Color3.fromRGB(236, 219, 137)
elseif distFromCenter > 6 then
    material = Enum.Material.LeafyGrass
    color = Color3.fromRGB(120, 160, 80)
end

return height, material, color, isMountain
end

local function createTree(position)
local trunk = Instance.new("Part")
trunk.Size = Vector3.new(1.5, math.random(4, 7), 1.5)
trunk.Position = position + Vector3.new(math.random(-9, 9), trunk.Size.Y/2, math.random(-9, 9))
trunk.Color = Color3.fromRGB(92, 64, 51)
trunk.Material = Enum.Material.Wood
trunk.Anchored = true
trunk.Parent = environmentFolder

local leaves = Instance.new("Part")
leaves.Shape = Enum.PartType.Ball
leaves.Size = Vector3.new(6, 6, 6)
leaves.Position = trunk.Position + Vector3.new(0, trunk.Size.Y/2, 0)
leaves.Color = Color3.fromRGB(34, 139, 34)
leaves.Material = Enum.Material.Grass
leaves.Anchored = true
leaves.Parent = environmentFolder
end

local function spawnGrid()
local mapCenter = startPos + Vector3.new(totalWidth/2, 0, totalWidth/2)

for x = 1, gridSize do
    for z = 1, gridSize do
        local height, biomeMat, biomeColor, isMountain = getBiomeData(x, z)
        local finalPos = startPos + Vector3.new((x - 1) * spacing, height, (z - 1) * spacing)

        if isMountain then
            -- Generate a Wedge facing the center for a sloped mountain look
            local mountainWedge = Instance.new("WedgePart")
            mountainWedge.Size = Vector3.new(10, height, 10)
            mountainWedge.Position = finalPos - Vector3.new(0, height/2, 0)
            mountainWedge.Material = biomeMat
            mountainWedge.Color = biomeColor
            mountainWedge.Anchored = true
            
            -- Orient wedge to face the center of the map
            local lookAtPos = Vector3.new(mapCenter.X, mountainWedge.Position.Y, mapCenter.Z)
            mountainWedge.CFrame = CFrame.lookAt(mountainWedge.Position, lookAtPos)
            mountainWedge.Parent = plotsFolder
        else
            local newPlot = plotTemplate:Clone()
            newPlot.Position = finalPos
            newPlot.Parent = plotsFolder

            local newFloor = plotFloor:Clone()
            newFloor.Position = finalPos - Vector3.new(0, 15, 0)
            newFloor.Material = biomeMat
            newFloor.Color = biomeColor
            newFloor.Parent = newPlot

            local logicScript = script.Parent:FindFirstChild("ProximityPlotScript")
            if logicScript then
                local cloneScript = logicScript:Clone()
                cloneScript.Parent = newPlot
                cloneScript.Enabled = true
            end

            -- Randomly spawn trees in grassy biomes, away from the direct center
            if biomeMat == Enum.Material.Grass and math.random() > 0.85 and (x < 12 or x > 18) then
                createTree(finalPos)
            end
        end
    end
end
end

spawnGrid()
