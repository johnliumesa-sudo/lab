local clerk = game:GetService("ReplicatedStorage"):FindFirstChild("NPCs"):FindFirstChild("Clerks"):WaitForChild("Model")
local clerkScript = script.Parent:FindFirstChild("ClerkScript")
local dialogManager = script.Parent.Parent:FindFirstChild("UI"):FindFirstChild("DialogManager")
clerkScript.Parent = clerk
dialogManager.Parent = clerk
local clerkFolder =  game:GetService("Workspace"):FindFirstChild("NPCs") :FindFirstChild("Clerks") 
local spawnRange = 96
local clerkCount = 3

local function  randomSpawn(index)
    local xpos = math.random (-spawnRange, spawnRange)
    local zpos = math.random (-spawnRange, spawnRange)
    local ypos = 4
    local clerkClone = clerk:Clone()
    clerkClone.Parent = clerkFolder
    clerkClone.Name = ("clerkClone_" .. tostring(index))
    clerkClone.PrimaryPart = clerkClone:FindFirstChild("HumanoidRootPart")
    clerkClone:PivotTo(CFrame.new(xpos,ypos,zpos))
    return  
end

for i = 1, clerkCount do
    randomSpawn(i)
end
