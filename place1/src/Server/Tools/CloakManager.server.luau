local cloak = game:GetService("ReplicatedStorage"):FindFirstChild("Tools"):FindFirstChild("Cloaks"):WaitForChild("Tool")
local cloakScript = script.Parent:FindFirstChild("CloakScript")
cloakScript.Parent = cloak
local cloaksFolder = game:GetService("Workspace"):FindFirstChild("Tools"):FindFirstChild("Cloaks")
local spawnRange = 48
local cloakCount = 100

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
  local cloakClone = cloak:Clone()
  cloakClone.Name = ("Cloak")
  local cloakHandleClone = cloakClone:FindFirstChild("Handle")
  local spawnerClone = spawner:Clone()
  local spawnerScriptClone = spawnerClone:WaitForChild("ToolSpawnerScript")
  spawnerClone.Parent = spawnersFolder
  spawnerClone.Position = Vector3.new(xpos,1,zpos)
  spawnerClone.Anchored = true
  spawnerScriptClone.Parent = spawnerClone
  cloakClone.Parent = cloaksFolder
  cloakHandleClone.Position = Vector3.new(xpos,4,zpos)
  cloakHandleClone.Anchored = true
  local cloakScriptClone = cloakClone:WaitForChild("CloakScript")
  cloakScriptClone.Parent = cloakClone
  return
end

for i = 1, cloakCount do
   randomSpawn()
   task.wait(20)
end
