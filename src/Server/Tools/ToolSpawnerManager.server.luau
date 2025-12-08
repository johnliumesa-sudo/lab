local spawner = game:GetService("ReplicatedStorage"):FindFirstChild("Tools"):FindFirstChild("ToolSpawners"):WaitForChild("Part")
local spawnerScript = script.Parent:FindFirstChild("ToolSpawnerScript")
spawnerScript.Parent = spawner
local spawnersFolder = game:GetService("Workspace"):FindFirstChild("Tools"):FindFirstChild("ToolSpawners")
local spawnRange = 48
local spawnerCount = 3

local function randomSpawn()
  local xpos = math.random (-spawnRange, spawnRange)
  local zpos = math.random (-spawnRange, spawnRange)
  local ypos = 2
  local spawnerClone = spawner:Clone()
  spawnerClone.Parent = spawnersFolder
  spawnerClone.Position = Vector3.new(xpos,ypos,zpos)
  spawnerClone.Anchored = true
  local spawnerScriptClone = spawnerClone:WaitForChild("ToolSpawnerScript")
  spawnerScriptClone.Parent = spawnerClone
  return
end

local function movements(ToolsClone)
  local spinRate = math.rad
  while true do
      -- Movement logic placeholder
  end
end

for i = 1, spawnerCount do
   randomSpawn()
end
