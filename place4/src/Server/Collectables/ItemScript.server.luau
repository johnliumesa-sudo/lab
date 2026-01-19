local itemBase = Instance.new("Part")
itemBase.Parent =  game:GetService("ReplicatedStorage"):FindFirstChild("Collectables"):FindFirstChild("Items")
itemBase.Anchored = true
local item = Instance.new ("SpecialMesh")
item.Parent = itemBase
item.MeshId = "rbxassetid://16964238833"
item.TextureId = "rbxassetid://16964238915"
item.Scale = Vector3.new(1.5, 1.5, 1.5)
local rotationRate = 3
local Players = game:GetService("Players")
local itemFolder = game:GetService("Workspace"):FindFirstChild("Collectables"):FindFirstChild("Items")

local function rotate()
    script.Parent.CFrame *= CFrame.Angles(0, rotationRate, 0)  
end

local function onTyped(otherPart)
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
   elseif character:IsA("Part") or character:IsA("MeshPart") then
      script.Parent.Anchored = true
   end
end

if script.Parent.Parent == itemFolder then
  task.wait(9)
  script.Parent:Destroy()
  --game:GetService("RunService").Heartbeat:Connect(rotate)
end
