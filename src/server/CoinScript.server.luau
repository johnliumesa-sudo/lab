-- variables
local coinBase = Instance.new("Part")
coinBase.Parent =  game:GetService("ReplicatedStorage"):FindFirstChild("Shared"):FindFirstChild("currencies")
coinBase.Name = "Part"
local coin = Instance.new ("SpecialMesh")
coin.Parent = coinBase
coin.MeshId = "rbxassetid://71877336332186"
coin.TextureId = "rbxassetid://9460443119"
-- coinBase = script.Parent
coinBase.Anchored = true
-- local onTouchedRemoteEvent = Instance.new("RemoteEvent")
-- onTouchedRemoteEvent.Parent = game:GetService("ReplicatedStorage"):FindFirstChild("Shared"):FindFirstChild("RemoteEvents")
local rotationRate = 3
local bobRange = 5


-- functions
local function rotate()
    coinBase.CFrame *= CFrame.Angles(0, rotationRate, 0) 
end

-- local function onTouched()
--     onTouchedRemoteEvent:FireClient
-- end

-- executions
game:GetService("RunService").Heartbeat:Connect(rotate)
