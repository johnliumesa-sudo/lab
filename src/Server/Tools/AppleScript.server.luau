local appleBase = Instance.new("Tool")
appleBase.Parent =  game:GetService("ReplicatedStorage"):FindFirstChild("Tools"):FindFirstChild("Apples")
local appleHandle = Instance.new("Part")
appleHandle.Parent =  appleBase
appleHandle.Name = "Handle"
local apple = Instance.new ("SpecialMesh")
apple.Parent = appleHandle
apple.MeshId = "rbxassetid://14120747098"
apple.Scale = Vector3.new(50, 50, 50)
apple.TextureId = "rbxassetid://14120747189"
apple.Scale = Vector3.new(0.05, 0.05, 0.05)
local appleFolder = game:GetService("Workspace"):FindFirstChild("Tools"):FindFirstChild("Apples")
local eatAnim = Instance.new("Animation")
eatAnim.AnimationId = "rbxassetid://15967404108" -- REPLACE THIS with your actual Animation ID
eatAnim.Parent = script

local function onClicked()
   local character = script.Parent.Parent
   local humanoid = character:FindFirstChild("Humanoid")
   -- CORRECTED: Load the animation onto the humanoid, then play the track
   if humanoid then
      local animator = humanoid:FindFirstChild("Animator") or humanoid:WaitForChild("Animator")
      if animator then
	 local track = animator:LoadAnimation(eatAnim)
	 track:Play()
      end
      if humanoid.Health < humanoid.MaxHealth then
      humanoid.Health = humanoid.Health + 20
      elseif humanoid.MaxHealth < 200 then
	humanoid.MaxHealth = humanoid.MaxHealth + 20
	humanoid.Health = humanoid.MaxHealth - 1
      else
	print(humanoid.MaxHealth.." is the maximum health reachable!")
      end  
      script.Parent:Destroy()
   end
end

local function onEquipped()
   local character = script.Parent.Parent
    if script.parent:FindFirstChild("Handle") then
       script.parent:FindFirstChild("Handle").Anchored = false
    end
    script.Parent.Activated:Connect(onClicked)
end

if script.Parent.Parent == appleFolder then
  script.Parent.Equipped:Connect(onEquipped)
end

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
local slashAnim = Instance.new("Animation")
slashAnim.AnimationId = "rbxassetid://522635514" -- REPLACE THIS with your actual Animation ID
slashAnim.Parent = script

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
   local character = script.Parent.Parent
   local humanoid = character:FindFirstChild("Humanoid")
   -- CORRECTED: Load the animation onto the humanoid, then play the track
   if humanoid then
      local animator = humanoid:FindFirstChild("Animator") or humanoid:WaitForChild("Animator")
      if animator then
	 local track = animator:LoadAnimation(slashAnim)
	 track:Play()
      end
   end
end

local function onEquipped()
   local character = script.Parent.Parent
    character.Humanoid.WalkSpeed = 30
    if script.parent:FindFirstChild("Handle") then
       script.parent:FindFirstChild("Handle").Anchored = false
    end
    script.Parent.Activated:Connect(onClicked)
    script.Parent:FindFirstChild("Handle").Touched:Connect(onTouched)
end

if script.Parent.Parent == swordFolder then
  script.Parent.Equipped:Connect(onEquipped)
end
