local speedCoilBase = Instance.new("Tool")
speedCoilBase.Parent =  game:GetService("ReplicatedStorage"):FindFirstChild("Tools"):FindFirstChild("SpeedCoils")
local speedCoilHandle = Instance.new("MeshPart")
speedCoilHandle.Parent =  speedCoilBase
speedCoilHandle.Name = "Handle"
local speedCoil = Instance.new ("SpecialMesh")
speedCoil.Parent = speedCoilHandle
speedCoil.MeshId = "rbxassetid://16606212"
speedCoil.TextureId = "rbxassetid://16606141"
local rotationRate = 3
local Players = game:GetService("Players")
local speedCoilFolder = game:GetService("Workspace"):FindFirstChild("Tools"):FindFirstChild("SpeedCoils")

local function rotate()
    script.Parent.CFrame *= CFrame.Angles(0, rotationRate, 0)  
end

local function onEquipped()
    local character = script.Parent.Parent
    character.Humanoid.JumpHeight = 15
    if script.parent:FindFirstChild("Handle") then
       script.parent:FindFirstChild("Handle").Anchored = false
    end
end

if script.Parent.Parent == speedCoilFolder then
  script.Parent.Equipped:Connect(onEquipped)
end
