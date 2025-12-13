local sword = game:GetService("ReplicatedStorage"):FindFirstChild("Tools"):FindFirstChild("Swords"):WaitForChild("Tool")
local swordScript = script.Parent:FindFirstChild("SwordScript")
local swordsFolder = game:GetService("Workspace"):FindFirstChild("Tools"):FindFirstChild("Swords")
local spawnRange = 48
local swordCount = 3

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
  local swordClone = sword:Clone()
  local swordHandleClone = swordClone:FindFirstChild("Handle")
  local spawnerClone = spawner:Clone()
  local spawnerScriptClone = spawnerClone:WaitForChild("ToolSpawnerScript")
  spawnerClone.Parent = spawnersFolder
  spawnerClone.Position = Vector3.new(xpos,1,zpos)
  spawnerClone.Anchored = true
  spawnerScriptClone.Parent = spawnerClone
  swordClone.Parent = swordsFolder
  swordHandleClone.Position = Vector3.new(xpos,4,zpos)
  swordHandleClone.Anchored = true
  local swordScriptClone = swordClone:WaitForChild("SwordScript")
  swordScriptClone.Parent = swordClone
  return
end

local function movements(ToolsClone)
  local spinRate = math.rad
  while true do
      -- Movement logic placeholder
  end
end

for i = 1, swordCount do
   randomSpawn()
end
