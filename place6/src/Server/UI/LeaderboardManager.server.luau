local Players = game:GetService("Players")

local function onPlayerAdded(player)
local leaderstats = Instance.new("Folder")
leaderstats.Name = "leaderstats"
leaderstats.Parent = player

  local cash = Instance.new("IntValue")
  cash.Name = "Cash"
  cash.Value = 10 -- Starting capital to buy first Tomato
  cash.Parent = leaderstats
end

Players.PlayerAdded:Connect(onPlayerAdded)
