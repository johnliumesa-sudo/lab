local present = game:GetService("ReplicatedStorage"):FindFirstChild("Collectables"):FindFirstChild("Presents"):FindFirstChild("Part")
local presentScript = script.Parent:FindFirstChild("PresentScript")
presentScript.Parent = present
local presentsFolder = game:GetService("Workspace"):FindFirstChild("Collectables"):FindFirstChild("Presents")
local spawnRange = 24
local presentCount = 100

local function randomSpawn()
  local xpos = math.random (-spawnRange, spawnRange)
  local zpos = 5
  local ypos = 30
  task.wait(2)
  local present = game:GetService("ReplicatedStorage"):FindFirstChild("Collectables"):FindFirstChild("Presents"):FindFirstChild("Part")
  if present then
     local presentClone = present:Clone()
     presentClone.Parent = presentsFolder
     presentClone.Position = Vector3.new(xpos,ypos,zpos)
     presentClone.Anchored = false
  end
  return
end

for i = 1, presentCount do
    randomSpawn()
    task.wait(3)
end
