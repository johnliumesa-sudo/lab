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

local function onEquipped()
    local character = script.Parent.Parent
    character.Humanoid.WalkSpeed = 30
    if script.parent:FindFirstChild("Handle") then
       script.parent:FindFirstChild("Handle").Anchored = false
    end
    script.parent:FindFirstChild("Handle")
end

local function onAttack()
   local player = script.Parent.Parent
   local animator = player:WaitForChild("Animator") 
   local slashAnim = animator:LoadAnimation(player.Animate.toolslash.ToolSlashAnim)
   slashAnim:Play()
end

if script.Parent.Parent == swordFolder then
  script.Parent.Equipped:Connect(onEquipped)
  
end
