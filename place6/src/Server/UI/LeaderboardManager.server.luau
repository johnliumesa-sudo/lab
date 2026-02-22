local Players = game:GetService("Players")

local function onPlayerAdded(player)
local leaderstats = Instance.new("Folder")
leaderstats.Name = "leaderstats"
leaderstats.Parent = player

local cash = Instance.new("IntValue")
cash.Name = "Cash"
cash.Value = 100 
cash.Parent = leaderstats

-- Hidden stats for upgrades
local stats = Instance.new("Folder")
stats.Name = "Stats"
stats.Parent = player

local speedMod = Instance.new("NumberValue")
speedMod.Name = "SpeedMod"
speedMod.Value = 1.0 -- Lower is faster
speedMod.Parent = stats

local valueMod = Instance.new("NumberValue")
valueMod.Name = "ValueMod"
valueMod.Value = 1.0 -- Higher is better
valueMod.Parent = stats

local vehicleLevel = Instance.new("IntValue")
vehicleLevel.Name = "VehicleLevel"
vehicleLevel.Value = 0
vehicleLevel.Parent = stats

local landLevel = Instance.new("IntValue")
landLevel.Name = "LandLevel"
landLevel.Value = 0
landLevel.Parent = stats
end

Players.PlayerAdded:Connect(onPlayerAdded)
