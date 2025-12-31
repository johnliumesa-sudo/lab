local presentBase = Instance.new("Part")
presentBase.Parent =  game:GetService("ReplicatedStorage"):FindFirstChild("Collectables"):FindFirstChild("Presents")
presentBase.Anchored = true
local present = Instance.new ("SpecialMesh")
present.Parent = presentBase
present.MeshId = "rbxassetid://13354760399"
present.TextureId = "rbxassetid://13354760424"
present.Scale = Vector3.new(0.3, 0.3, 0.3)
local rotationRate = 3
local tools = game:GetService("Workspace"):FindFirstChild("Tools")
local Players = game:GetService("Players")
local presentFolder = game:GetService("Workspace"):FindFirstChild("Collectables"):FindFirstChild("Presents")

local function rotate()
    script.Parent.CFrame *= CFrame.Angles(0, rotationRate, 0)  
end

local function onTouched(otherPart)
   local character = otherPart.Parent
   local humanoid = character:FindFirstChildWhichIsA("Humanoid")
   if humanoid then
	local player = Players:GetPlayerFromCharacter(character)
	if player then
	   local leaderstats = player:WaitForChild("leaderstats")
	   script.Parent:Destroy()
	   if leaderstats.CoinCount.Value < 500 then
	      if leaderstats.CoinCount.Value >= 10 then
		 leaderstats.CoinCount.Value = leaderstats.CoinCount.Value*2
		 humanoid.health += 25
	      else
		 leaderstats.CoinCount.Value += 50
		 humanoid.health += 50	
	      end		
	   else	
	      humanoid.health = humanoid.MaxHealth
	   end
	end
   end
end

if script.Parent.Parent == presentFolder then
  script.Parent.Touched:Connect(onTouched)
  game:GetService("RunService").Heartbeat:Connect(rotate)
end
