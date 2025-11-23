local patrol = game:GetService("ReplicatedStorage"):FindFirstChild("NPCs"):FindFirstChild("Patrols"):WaitForChild("Model")
local patrolScript = script.Parent:FindFirstChild("PatrolScript")
patrolScript.Parent = patrol
local patrolFolder =  game:GetService("Workspace"):FindFirstChild("NPCs") :FindFirstChild("Patrols") 
local spawnRange = 96
local patrolCount = 24

local function  randomSpawn(index)
    local xpos = math.random (-spawnRange, spawnRange)
    local zpos = math.random (-spawnRange, spawnRange)
    local ypos = 4
    local patrolClone = patrol:Clone()
    patrolClone.Parent = patrolFolder
    patrolClone.Name = ("patrolClone_" .. tostring(index))
    patrolClone.PrimaryPart = patrolClone:FindFirstChild("HumanoidRootPart")
    patrolClone:PivotTo(CFrame.new(xpos,ypos,zpos))
    return  
end

for i = 1, patrolCount do
    randomSpawn(i)
end
