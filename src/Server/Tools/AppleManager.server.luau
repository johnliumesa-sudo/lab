local apple = game:GetService("ReplicatedStorage"):FindFirstChild("Collectables"):FindFirstChild("Apples"):WaitForChild("Part")
local appleScript = script.Parent:FindFirstChild("AppleScript")
if appleScript then
    appleScript.Parent = apple
else
    return
end
local applesFolder = game:GetService("Workspace"):FindFirstChild("Collectables"):FindFirstChild("Apples")
local spawnRange = 48
local appleCount = 100

local function randomSpawn()
  local xpos = math.random (-spawnRange, spawnRange)
  local zpos = math.random (-spawnRange, spawnRange)
  local apple = game:GetService("ReplicatedStorage"):FindFirstChild("Collectables"):FindFirstChild("Apples"):WaitForChild("Part")
  local appleClone = apple:Clone()
  appleClone.Name = ("Apple")
  appleClone.Parent = applesFolder
  appleClone.Position = Vector3.new(xpos,4,zpos)
  appleClone.Anchored = true
  return
end

for i = 1, appleCount do
   randomSpawn()
   task.wait(20)
end
