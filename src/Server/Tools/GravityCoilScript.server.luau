local gravityCoilBase = Instance.new("Tool")
gravityCoilBase.Parent =  game:GetService("ReplicatedStorage"):FindFirstChild("Tools"):FindFirstChild("GravityCoils")
local gravityCoilHandle = Instance.new("Part")
gravityCoilHandle.Parent =  gravityCoilBase
gravityCoilHandle.Name = "Handle"
local gravityCoil = Instance.new ("SpecialMesh")
gravityCoil.Parent = gravityCoilHandle
gravityCoil.MeshId = "rbxassetid://12264149190"
gravityCoil.TextureId = "rbxassetid://16606141"
local rotationRate = 3
local Players = game:GetService("Players")
local gravityCoilFolder = game:GetService("Workspace"):FindFirstChild("Tools"):FindFirstChild("GravityCoils")

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

if script.Parent.Parent == gravityCoilFolder then
  script.Parent.Equipped:Connect(onEquipped)
end
