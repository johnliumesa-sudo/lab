local christmastree = game:GetService("ReplicatedStorage"):FindFirstChild("Establishments"):FindFirstChild("ChristmasTrees"):WaitForChild("Part")
local christmastreeScript = script.Parent:FindFirstChild("ChristmasTreeScript")
christmastreeScript.Parent = christmastree
local christmastreesFolder = game:GetService("Workspace"):FindFirstChild("Establishments"):FindFirstChild("ChristmasTrees")
local spawnRange = 48
local christmastreeCount = 1

local function randomSpawn()
  local xpos = 0
  local zpos = 0
  local ypos = 3
  local christmastreeClone = christmastree:Clone()
  christmastreeClone.Parent = christmastreesFolder
  christmastreeClone.Position = Vector3.new(xpos,ypos,zpos)
  return
end

for i = 1, christmastreeCount do
    --randomSpawn()
end
