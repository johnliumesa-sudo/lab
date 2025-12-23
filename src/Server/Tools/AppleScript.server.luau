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
