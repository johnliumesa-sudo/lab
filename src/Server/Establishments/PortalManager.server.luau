local portal = game:GetService("ReplicatedStorage"):FindFirstChild("Establishments"):FindFirstChild("Portals"):WaitForChild("Part")
local portalScript = script.Parent:FindFirstChild("PortalScript")
portalScript.Parent = portal
local portalsFolder = game:GetService("Workspace"):FindFirstChild("Establishments"):FindFirstChild("Portals")
local spawnRange = 48
local portalCount = 6

local function randomSpawn()
  local xpos = math.random (-spawnRange, spawnRange)
  local zpos = math.random (-spawnRange, spawnRange)
  local ypos = 3
  local portalClone = portal:Clone()
  portalClone.Parent = portalsFolder
  portalClone.Position = Vector3.new(xpos,ypos,zpos)
  local portalScriptClone = portalClone:WaitForChild("PortalScript")
  portalScriptClone.Parent = portalClone
  return
end

for i = 1, portalCount do
    randomSpawn()
end
