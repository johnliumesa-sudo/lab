local apple = game:GetService("ReplicatedStorage"):FindFirstChild("Tools"):FindFirstChild("Apples"):WaitForChild("Tool")
local appleScript = script.Parent:FindFirstChild("AppleScript")
if appleScript then
    appleScript.Parent = apple
else
    return
end
local applesFolder = game:GetService("Workspace"):FindFirstChild("Tools"):FindFirstChild("Apples")
local spawnRange = 48
local appleCount = 3

local spawner = game:GetService("ReplicatedStorage"):FindFirstChild("Tools"):FindFirstChild("ToolSpawners"):WaitForChild("Part")
local spawnerScript = script.Parent:FindFirstChild("ToolSpawnerScript")
if spawnerScript then
   spawnerScript.Parent = spawner
end
local spawnersFolder = game:GetService("Workspace"):FindFirstChild("Tools"):FindFirstChild("ToolSpawners")
local spawnRange = 48
local spawnerCount = 3

local function randomSpawn()
  local xpos = math.random (-spawnRange, spawnRange)
  local zpos = math.random (-spawnRange, spawnRange)
  local appleClone = apple:Clone()
  appleClone.Name = ("Apple")
  local appleHandleClone = appleClone:FindFirstChild("Handle")
  local spawnerClone = spawner:Clone()
  local spawnerScriptClone = spawnerClone:WaitForChild("ToolSpawnerScript")
  spawnerClone.Parent = spawnersFolder
  spawnerClone.Position = Vector3.new(xpos,1,zpos)
  spawnerClone.Anchored = true
  spawnerScriptClone.Parent = spawnerClone
  appleClone.Parent = applesFolder
  appleHandleClone.Position = Vector3.new(xpos,4,zpos)
  appleHandleClone.Anchored = true
  local appleScriptClone = appleClone:WaitForChild("AppleScript")
  appleScriptClone.Parent = appleClone
  return
end

for i = 1, appleCount do
   randomSpawn()
end
