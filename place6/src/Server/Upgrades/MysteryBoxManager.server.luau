local boxPart = Instance.new("Part")
boxPart.Name = "MysteryBox"
boxPart.Size = Vector3.new(4, 4, 4)
boxPart.Position = Vector3.new(0, 2, -15) -- Placed away from plots
boxPart.Color = Color3.fromRGB(148, 0, 211) -- Purple
boxPart.Material = Enum.Material.Neon
boxPart.Anchored = true
boxPart.Parent = game:GetService("Workspace")

local cd = Instance.new("ClickDetector")
cd.Parent = boxPart

local spinCost = 50

local function spinWheel(player)
local leaderstats = player:FindFirstChild("leaderstats")
if not leaderstats then return end
local cash = leaderstats:FindFirstChild("Cash")

  if cash.Value >= spinCost then
      cash.Value -= spinCost
      
      -- Risk vs Reward Logic
      local chance = math.random(1, 100)
      if chance <= 50 then
          -- 50% chance to lose (get nothing or very little)
          print("Bad luck!")
      elseif chance <= 80 then
          -- 30% chance to break even or small profit
          cash.Value += math.random(40, 80)
          print("Small Win!")
      elseif chance <= 95 then
          -- 15% chance for big win
          cash.Value += math.random(100, 200)
          print("Big Win!")
      else
          -- 5% chance for Jackpot
          cash.Value += 1000
          print("JACKPOT!")
      end
  end
end

cd.MouseClick:Connect(spinWheel)
