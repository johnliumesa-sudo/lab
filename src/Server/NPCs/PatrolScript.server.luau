local StartingPosition = Vector3.new(0, 5, 0)
local Players = game:GetService("Players")

local function createPatrol()
    local patrol = Instance.new("Model")
    patrol.Parent = game:GetService("ReplicatedStorage"):FindFirstChild("NPCs"):FindFirstChild("Patrols")
    
    local hrp = Instance.new("Part")
    hrp.Name = "HumanoidRootPart"
    hrp.Size = Vector3.new(2, 2, 1)
    hrp.Transparency = 1
    hrp. CFrame = CFrame.new(StartingPosition)
    hrp.Anchored = false
    hrp.Parent = patrol
    hrp.CanCollide = true
    
    local humanoid = Instance.new("Humanoid")
    humanoid.Parent = patrol
    humanoid.WalkSpeed = 16
    humanoid.JumpPower = 50
    humanoid.Health = 100

    patrol.PrimaryPart = hrp

    local torso = Instance.new("Part")
    torso.Name = "Torso"
    torso.Size = Vector3.new(2, 2, 1)
    torso.Color = Color3.new(1, 0, 0) -- Red color for visibility
    torso.Parent = patrol

    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(1, 1, 1)
    head.Color = Color3.new(1, 0.8, 0.6) -- Skin color
    head.Parent = patrol
    
    local headMesh = Instance.new("SpecialMesh")
    headMesh.MeshType = Enum.MeshType.Head
    headMesh.Parent = head

    local weld_hrp_torso = Instance.new("WeldConstraint")
    weld_hrp_torso.Part0 = hrp
    weld_hrp_torso.Part1 = torso
    weld_hrp_torso.Parent = hrp

    torso.CFrame = hrp.CFrame * CFrame.new(0, 1.5, 0)
    head.CFrame = torso.CFrame * CFrame.new(0, 2, 0)

    local weld_head_tosro = Instance.new("WeldConstraint")
    weld_head_tosro.Part0 = head
    weld_head_tosro.Part1 = torso
    weld_head_tosro.Parent = torso

    return patrol, hrp, humanoid,torso
end

local function onTouched(otherPart)
    local character = otherPart.Parent
    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
    if humanoid then
        local player = Players:GetPlayerFromCharacter(character)  -- Character's parent is the Player
        local leaderstats = player:FindFirstChild("leaderstats")
        local coinCount = leaderstats:WaitForChild("CoinCount")
        leaderstats.CoinCount.Value -= 3
        script.Parent:FindFirstChild("HumanoidRootPart").CanTouch = false
        script.Parent:FindFirstChild("Torso").Color = Color3.new(0.152941, 0.784313, 0.117647) 
        if coinCount.Value < 0 then
            humanoid.Health = 0
            coinCount.Value = 0
        end
        task.wait(5)
        script.Parent:FindFirstChild("Torso").Color = Color3.new(1, 0, 0)
        script.Parent:FindFirstChild("HumanoidRootPart").CanTouch = true 
    end
end

local patrol, hrp, humanoid,torso = createPatrol()
if script.Parent.Parent == game.Workspace:FindFirstChild("NPCs"):FindFirstChild("Patrols") then
    script.Parent:FindFirstChild("HumanoidRootPart").Touched:Connect(onTouched)
end
