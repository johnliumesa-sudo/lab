local coin = game:GetService("ReplicatedStorage"):FindFirstChild("Collectables"):FindFirstChild("Coins"):WaitForChild("Part")
local coinScript = script.Parent:FindFirstChild("CoinScript")
coinScript.Parent = coin
local coinsFolder = game:GetService("Workspace"):FindFirstChild("Collectables"):FindFirstChild("Coins")
local spawnRange = 48
local coinCount = 21

local function randomSpawn()
  local xpos = math.random (-spawnRange, spawnRange)
  local zpos = math.random (-spawnRange, spawnRange)
  local ypos = math.random (5, 30)
  local coinClone = coin:Clone()
  coinClone.Parent = coinsFolder
  coinClone.Position = Vector3.new(xpos,ypos,zpos)
  local coinScriptClone = coinClone:WaitForChild("CoinScript")
  coinScriptClone.Parent = coinClone
  return
end

local function movements(collectablesClone)
  local spinRate = math.rad
  while true do
      -- Movement logic placeholder
  end
end

for i = 1, coinCount do
    randomSpawn()
end
