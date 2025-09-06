--variables
local collectable = game.Workspace:FindFirstChild("Collectables"):FindFirstChild("MeshPartCollectable")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local collectablesFolder = Instance.new("Folder")
collectablesFolder.Parent = game.Workspace
collectablesFolder.Name = ("Collectables")
local spawnRange = 48
local coinCount = 21


--functions
local function  randomSpawn()
    local xpos = math.random (1, spawnRange)
    local zpos = math.random (1, spawnRange)
    local ypos = 5
    local collectablesClone = collectable:Clone()
    collectablesClone.Parent = collectablesFolder
    collectablesClone.Name = ("CollectableClone")
    collectablesClone.Position = CFrame.new(xpos,ypos,zpos)
end

--executions
for i = 1, coinCount do
    randomSpawn()
end