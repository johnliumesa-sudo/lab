local players = game:GetService("Players")

local function onPlayerSpawn(player)
  local leaderstats = Instance.new("Folder")
  leaderstats.Name = "leaderstats"
  leaderstats.Parent = player
  local coinCount = Instance.new("IntValue")
  coinCount.Name = "CoinCount"
  coinCount.Parent = leaderstats
  coinCount.Value = 0
end

players.PlayerAdded:Connect(onPlayerSpawn)
