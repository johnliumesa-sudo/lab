--variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local npc = ReplicatedStorage:FindFirstChild("Shared"):FindFirstChild("NPCs"):WaitForChild("Model")
local npcScript = script.Parent:FindFirstChild("NPCScript")
npcScript.Parent = npc
local npcFolder =  game:GetService("Workspace"):FindFirstChild("NPCs") 
local spawnRange = 24
local npcCount = 6

--functions
local function  randomSpawn()
    local xpos = math.random (-spawnRange, spawnRange)
    local zpos = math.random (-spawnRange, spawnRange)
    local ypos = 4
    local npcClone = npc:Clone()
    npcClone.Parent = npcFolder
    npcClone:WaitForChild("HumanoidRootPart").Position = Vector3.new(xpos,ypos,zpos)
    return  
end



--executions
for i = 1, npcCount do
    randomSpawn()
end