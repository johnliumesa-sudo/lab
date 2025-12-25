local christmasTreeBase = Instance.new("Part")
christmasTreeBase.Parent =  game:GetService("ReplicatedStorage"):FindFirstChild("Establishments"):FindFirstChild("ChristmasTrees")
christmasTreeBase.Anchored = true
local christmasTree = Instance.new ("SpecialMesh")
christmasTree.Parent = christmasTreeBase
christmasTree.MeshId = "rbxassetid://551508688"
christmasTree.TextureId = "rbxassetid://551508937"

local function rotate()
   christmasTreeBase.CFrame *= CFrame.Angles(0, 0.005, 0)
end

if script.Parent.Parent == presentFolder then
  game:GetService("RunService").Heartbeat:Connect(rotate)
end
