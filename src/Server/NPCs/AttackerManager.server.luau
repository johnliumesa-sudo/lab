local attacker = game:GetService("ReplicatedStorage"):FindFirstChild("NPCs"):FindFirstChild("Attackers"):WaitForChild("Model")
local attackerScript = script.Parent:FindFirstChild("AttackerScript")
attackerScript.Parent = attacker
local attackerFolder =  game:GetService("Workspace"):FindFirstChild("NPCs") :FindFirstChild("Attackers") 
local spawnRange = 96
local attackerCount = 3

local function  randomSpawn(index)
    local xpos = math.random (-spawnRange, spawnRange)
    local zpos = math.random (-spawnRange, spawnRange)
    local ypos = 4
    local attackerClone = attacker:Clone()
    attackerClone.Parent = attackerFolder
    attackerClone.Name = ("attackerClone_" .. tostring(index))
    attackerClone.PrimaryPart = attackerClone:FindFirstChild("HumanoidRootPart")
    attackerClone:PivotTo(CFrame.new(xpos,ypos,zpos))
    return  
end

for i = 1, attackerCount do
    randomSpawn(i)
end
