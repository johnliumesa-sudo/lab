local players = game:GetService("Players")

local function onPlayerSpawn(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player
    local coinCount = Instance.new("IntValue")
    coinCount.Name = "CoinCount"
    coinCount.Parent = leaderstats
    coinCount.Value = 0
    -- Minimal Scripting: Toggle transparency on spawn
	player.CharacterAdded:Connect(function(char)
		for _, part in pairs(char:GetDescendants()) do
		    if part:IsA("BasePart") or part:IsA("Decal") then
			part.Transparency = 1
		    end
		end
	end)
end

players.PlayerAdded:Connect(onPlayerSpawn)
