local speedCoil = game:GetService("ReplicatedStorage"):FindFirstChild("Tools"):FindFirstChild("SpeedCoils"):WaitForChild("Tool")
local speedCoilScript = script.Parent:FindFirstChild("SpeedCoilScript")
speedCoilScript.Parent = speedCoil
local speedCoilsFolder = game:GetService("Workspace"):FindFirstChild("Tools"):FindFirstChild("SpeedCoils")
local spawnRange = 48
local speedCoilCount = 3

local spawner = game:GetService("ReplicatedStorage"):FindFirstChild("Tools"):FindFirstChild("ToolSpawners"):WaitForChild("Part")
local spawnerScript = script.Parent:FindFirstChild("ToolSpawnerScript")
spawnerScript.Parent = spawner
local spawnersFolder = game:GetService("Workspace"):FindFirstChild("Tools"):FindFirstChild("ToolSpawners")
local spawnRange = 48
local spawnerCount = 3

local function randomSpawn()
  local xpos = math.random (-spawnRange, spawnRange)
  local zpos = math.random (-spawnRange, spawnRange)
  local speedCoilClone = speedCoil:Clone()
  local speedCoilHandleClone = speedCoilClone:FindFirstChild("Handle")
  local spawnerClone = spawner:Clone()
  local spawnerScriptClone = spawnerClone:WaitForChild("ToolSpawnerScript")
  spawnerClone.Parent = spawnersFolder
  spawnerClone.Position = Vector3.new(xpos,1,zpos)
  spawnerClone.Anchored = true
  spawnerScriptClone.Parent = spawnerClone
  speedCoilClone.Parent = speedCoilsFolder
  speedCoilHandleClone.Position = Vector3.new(xpos,4,zpos)
  speedCoilHandleClone.Anchored = true
  local speedCoilScriptClone = speedCoilClone:WaitForChild("SpeedCoilScript")
  speedCoilScriptClone.Parent = speedCoilClone
  return
end

local function movements(ToolsClone)
  local spinRate = math.rad
  while true do
      -- Movement logic placeholder
  end
end

for i = 1, speedCoilCount do
   randomSpawn()
end
