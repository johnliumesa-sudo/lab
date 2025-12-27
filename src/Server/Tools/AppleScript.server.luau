local appleBase = Instance.new("Part")
appleBase.Parent =  game:GetService("ReplicatedStorage"):FindFirstChild("Collectables"):FindFirstChild("Apples")
local apple = Instance.new ("SpecialMesh")
apple.Parent = appleBase
apple.MeshId = "rbxassetid://14120747098"
apple.Scale = Vector3.new(50, 50, 50)
apple.TextureId = "rbxassetid://14120747189"
apple.Scale = Vector3.new(0.05, 0.05, 0.05)
local appleFolder = game:GetService("Workspace"):FindFirstChild("Collectables"):FindFirstChild("Apples")
local eatAnim = Instance.new("Animation")
eatAnim.AnimationId = "rbxassetid://15967404108" 
eatAnim.Parent = script

local function onTouched(otherPart)
    local character = otherPart.Parent
    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
    if humanoid then
      local Players = game:GetService("Players")
      local player = Players:GetPlayerFromCharacter(character)
      if player then
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
end

if script.Parent.Parent == appleFolder then
   script.Parent.Touched:Connect(onTouched)
end
