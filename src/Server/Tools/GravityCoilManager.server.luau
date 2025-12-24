local gravityCoil = game:GetService("ReplicatedStorage"):FindFirstChild("Tools"):FindFirstChild("GravityCoils"):WaitForChild("Tool")
local gravityCoilScript = script.Parent:FindFirstChild("GravityCoilScript")
gravityCoilScript.Parent = gravityCoil
local gravityCoilsFolder = game:GetService("Workspace"):FindFirstChild("Tools"):FindFirstChild("GravityCoils")
local spawnRange = 48
local gravityCoilCount = 3

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
  local gravityCoilClone = gravityCoil:Clone()
  gravityCoilClone.Name = ("GravityCoil")
  local gravityCoilHandleClone = gravityCoilClone:FindFirstChild("Handle")
  local spawnerClone = spawner:Clone()
  local spawnerScriptClone = spawnerClone:WaitForChild("ToolSpawnerScript")
  spawnerClone.Parent = spawnersFolder
  spawnerClone.Position = Vector3.new(xpos,1,zpos)
  spawnerClone.Anchored = true
  spawnerScriptClone.Parent = spawnerClone
  gravityCoilClone.Parent = gravityCoilsFolder
  gravityCoilHandleClone.Position = Vector3.new(xpos,4,zpos)
  gravityCoilHandleClone.Anchored = true
  local gravityCoilScriptClone = gravityCoilClone:WaitForChild("GravityCoilScript")
  gravityCoilScriptClone.Parent = gravityCoilClone
  return
end

local function movements(ToolsClone)
  local spinRate = math.rad
  while true do
      -- Movement logic placeholder
  end
end

for i = 1, gravityCoilCount do
   randomSpawn()
end
