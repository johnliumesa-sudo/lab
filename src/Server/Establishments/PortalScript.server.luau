local Players = game:GetService("Players")
local portal = Instance.new("Part")
portal.Shape = Enum.PartType.Cylinder
portal.Rotation = Vector3.new(0,0,90)
portal.Size = Vector3.new(1, 6, 6)
portal.Material = Enum.Material.Neon
portal.Color = Color3.new(0.047058, 0.486274, 0.925490)
local portalFrame = portal:Clone()
portalFrame.Size = Vector3.new(0.7, 7, 7)
portalFrame.Material = Enum.Material.Wood
portalFrame.Color = Color3.new(0.533333, 0.431372, 0.145098)
local teleportRange = 100
local Players = game:GetService("Players")
local portalsFolder = game:GetService("Workspace"):FindFirstChild("Establishments"):FindFirstChild("Portals")

local function onTouched(otherPart)
   local character = otherPart.Parent
   local humanoid = character:FindFirstChildWhichIsA("Humanoid")
   if humanoid then
      local player = Players:GetPlayerFromCharacter(character)
      if player then
	local hrp = character:FindFirstChildWhichIsA("HumanoidRootPart")
	hrp.Position = Vector3.new(math.random(1, teleportRange), 50, math.random(1, teleportRange))
      end
   end
end

if script.parent.parent = portalsFolder then  
  script.Parent.Touched:Connect(onTouched)
end
