--variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local npc = ReplicatedStorage:FindFirstChild("Shared"):FindFirstChild("NPCs"):WaitForChild("Model")
local npcScript = script.Parent:FindFirstChild("NPCScript")
if npcScript then
    npcScript.Parent = npc
else
    warn("NPCScript not found in NPCManager")
end
local npcFolder =  game:GetService("Workspace"):FindFirstChild("NPCs") 
local spawnRange = 96
local npcCount = 24

--functions
local function  randomSpawn(index)
    local xpos = math.random (-spawnRange, spawnRange)
    local zpos = math.random (-spawnRange, spawnRange)
    local ypos = 4
    local npcClone = npc:Clone()
    npcClone.Parent = npcFolder
    npcClone.Name = ("NPCClone_" .. tostring(index))
    npcClone.PrimaryPart = npcClone:FindFirstChild("HumanoidRootPart")
    npcClone:PivotTo(CFrame.new(xpos,ypos,zpos))

    return  
end



--executions
for i = 1, npcCount do
    randomSpawn(i)
end