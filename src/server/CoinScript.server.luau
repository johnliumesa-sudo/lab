-- variables
local coinBase = Instance.new("Part")
coinBase.Parent =  game:GetService("ReplicatedStorage"):FindFirstChild("Shared"):FindFirstChild("currencies")
coinBase.Anchored = true
local coin = Instance.new ("SpecialMesh")
coin.Parent = coinBase
coin.MeshId = "rbxassetid://71877336332186"
coin.TextureId = "rbxassetid://9460443119"
local rotationRate = 3
local Players = game:GetService("Players")
local collectablesFolder = game:GetService("Workspace"):FindFirstChild("Collectables")
      
      
-- functions
local function rotate()
    script.Parent.CFrame *= CFrame.Angles(0, rotationRate, 0)  
end
      
local function onTouched(otherPart)
    local character = otherPart.Parent
    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
    if humanoid then
        local player = Players:GetPlayerFromCharacter(character)  -- Character's parent is the Player
        local leaderstats = player:WaitForChild("leaderstats")
        local coinCount = leaderstats:WaitForChild("CoinCount")
        script.Parent:Destroy()
        leaderstats.CoinCount.Value += 10 
    end
end
-- executions
game:GetService("RunService").Heartbeat:Connect(rotate)
if script.Parent.Parent == collectablesFolder then
    script.Parent.Touched:Connect(onTouched)    
end