local gravityCoil = game:GetService("ReplicatedStorage"):FindFirstChild("Tools"):FindFirstChild("GravityCoils"):WaitForChild("Tool")
local gravityCoilScript = script.Parent:FindFirstChild("GravityCoilScript")
gravityCoilScript.Parent = gravityCoil
local gravityCoilsFolder = game:GetService("Workspace"):FindFirstChild("Tools"):FindFirstChild("GravityCoils")
local spawnRange = 48
local gravityCoilCount = 3

local function randomSpawn()
  local xpos = math.random (-spawnRange, spawnRange)
  local zpos = math.random (-spawnRange, spawnRange)
  local ypos = math.random (5, 30)
  local gravityCoilClone = gravityCoil:Clone()
  local gravityCoilHandleClone = gravityCoilClone:FindFirstChild("Handle")
  gravityCoilClone.Parent = gravityCoilsFolder
  gravityCoilHandleClone.Position = Vector3.new(xpos,ypos,zpos)
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
