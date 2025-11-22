--variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local collectable = ReplicatedStorage:FindFirstChild("Shared"):FindFirstChild("currencies"):WaitForChild("Part")
local coinScript = script.Parent:FindFirstChild("CoinScript")
coinScript.Parent = collectable
local Workspace = game:GetService("Workspace")
local collectablesFolder = workspace:FindFirstChild("Collectables") 
local spawnRange = 96
local coinCount = 84

--functions
local function  randomSpawn()
    local xpos = math.random (-spawnRange, spawnRange)
    local zpos = math.random (-spawnRange, spawnRange)
    local ypos = math.random (5, 30)
    local collectablesClone = collectable:Clone()
    collectablesClone.Parent = collectablesFolder
    -- collectablesClone.Name = ("CollectableClone")
    collectablesClone.Position = Vector3.new(xpos,ypos,zpos)
    local coinScriptClone = collectablesClone:WaitForChild("CoinScript")
    coinScriptClone.Parent = collectablesClone
    return  
end

local function movements(collectablesClone)
    local spinRate = math.rad
    while true do

    end    
end

--executions
for i = 1, coinCount do
    randomSpawn()
end