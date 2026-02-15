local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- Create folder for plots
local plotsFolder = Instance.new("Folder")
plotsFolder.Name = "FarmPlots"
plotsFolder.Parent = Workspace

-- Define plot template (or load from storage if you prefer prefab)
local plotTemplate = Instance.new("Part")
plotTemplate.Name = "Plot"
plotTemplate.Size = Vector3.new(8, 1, 8)
plotTemplate.Anchored = true
plotTemplate.Material = Enum.Material.Grass
plotTemplate.Color = Color3.fromRGB(75, 150, 75) -- Base Fertile Color

-- Add ClickDetector
local cd = Instance.new("ClickDetector")
cd.Parent = plotTemplate

-- Add Configuration values
local status = Instance.new("StringValue")
status.Name = "Status"
status.Value = "Empty" -- Empty, Growing
status.Parent = plotTemplate

-- Grid Settings
local gridSize = 4 -- 4x4 grid
local spacing = 10
local startPos = Vector3.new(0, 0.5, 0)

local function spawnGrid()
for x = 1, gridSize do
for z = 1, gridSize do
local newPlot = plotTemplate:Clone()
newPlot.Position = startPos + Vector3.new((x - 1) * spacing, 0, (z - 1) * spacing)
newPlot.Parent = plotsFolder

          -- Inject logic script
          local logicScript = script.Parent:FindFirstChild("PlotScript")
          if logicScript then
              local cloneScript = logicScript:Clone()
              cloneScript.Parent = newPlot
              cloneScript.Enabled = true
          end
      end
  end
end

spawnGrid()
