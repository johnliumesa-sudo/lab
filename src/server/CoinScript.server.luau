-- variables
local coin = script.Parent

local rotationRate = 3
local bobRange = 5

-- functions
local function rotate()
    coin.CFrame *= CFrame.Angles(0, rotationRate, 0)
    
end

-- executions
game:GetService("RunService").Heartbeat:Connect(rotate)
