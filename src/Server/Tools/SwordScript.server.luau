local swordBase = Instance.new("Tool")
swordBase.Grip = CFrame.new(0,-2.1,0)
swordBase.Parent =  game:GetService("ReplicatedStorage"):FindFirstChild("Tools"):FindFirstChild("Swords")
local swordHandle = Instance.new("Part")
swordHandle.Parent =  swordBase
swordHandle.Name = "Handle"
local sword = Instance.new ("SpecialMesh")
sword.Parent = swordHandle
sword.MeshId = "rbxassetid://483368738"
sword.TextureId = "rbxassetid://483368752"
sword.Scale = Vector3.new(0.005, 0.005, 0.005)
local swordRange = 5
local rotationRate = 3
local Players = game:GetService("Players")
local swordFolder = game:GetService("Workspace"):FindFirstChild("Tools"):FindFirstChild("Swords")

local function rotate()
    script.Parent.CFrame *= CFrame.Angles(0, rotationRate, 0)  
end

local function onTouched(otherPart)
    local character = otherPart.Parent
    if character == script.Parent.Parent then
      return
    else
      if character and character:IsA("Model") then
	  local humanoid = character:FindFirstChildWhichIsA("Humanoid")
	  if humanoid then
		local originHealth = humanoid.Health 
		humanoid.Health = originHealth - math.random(10,30)
	  end
      end
    end
end

local function onClicked()
   local slashAnim = script.Parent.Parent:FindFirstChild("Animate"):FindFirstChild("toolslash"):FindFirstChild("ToolSlashAnim")
   if slashAnim then
      slashAnim:Play()
   end
   script.Parent.onTouched:Connect(onTouched)
end

local function onEquipped(mouse)
   local character = script.Parent.Parent
    character.Humanoid.WalkSpeed = 30
    if script.parent:FindFirstChild("Handle") then
       script.parent:FindFirstChild("Handle").Anchored = false
    end
    script.parent:FindFirstChild("Handle")
    if script.parent.parent.parent.parent == game.Workpace then
       if mouse then
	  mouse.Button1Up:Connect(onClicked)
       end
    end
end

if script.Parent.Parent == swordFolder then
  script.Parent.Equipped:Connect(onEquipped)
end
