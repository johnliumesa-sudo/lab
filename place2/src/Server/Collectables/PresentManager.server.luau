local present = game:GetService("ReplicatedStorage"):FindFirstChild("Collectables"):FindFirstChild("Presents"):WaitForChild("Part")
local presentScript = script.Parent:FindFirstChild("PresentScript")
presentScript.Parent = present
local presentsFolder = game:GetService("Workspace"):FindFirstChild("Collectables"):FindFirstChild("Presents")
local spawnRange = 48
local presentCount = 6

local function randomSpawn()
  local xpos = math.random (-spawnRange, spawnRange)
  local zpos = math.random (-spawnRange, spawnRange)
  local ypos = 3
  local present = game:GetService("ReplicatedStorage"):FindFirstChild("Collectables"):FindFirstChild("Presents"):WaitForChild("Part")
  local presentClone = present:Clone()
  presentClone.Parent = presentsFolder
  presentClone.Position = Vector3.new(xpos,ypos,zpos)
  return
end

for i = 1, presentCount do
    randomSpawn()
end
