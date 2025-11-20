--variables
local StartingPosition = Vector3.new(0, 5, 0)
local RoamRange = 50
local Players = game:GetService("Players")
local DEFAULT_USER_ID = 12345678 -- Replace with a valid UserId for default appearance

--functions
local function createNPC()
    local npc = Instance.new("Model")
    npc.Name = "NPC"
    npc.Parent = game:GetService("Workspace"):FindFirstChild("NPCs")
    
    local hrp = Instance.new("Part")
    hrp.Name = "HumanoidRootPart"
    hrp.Size = Vector3.new(2, 2, 1)
    hrp.Transparency = 1
    hrp. CFrame = CFrame.new(StartingPosition)
    hrp.Anchored = false
    hrp.Parent = npc
    hrp.CanCollide = true
    
    local humanoid = Instance.new("Humanoid")
    humanoid.Parent = npc
    humanoid.WalkSpeed = 16
    humanoid.JumpPower = 50
    humanoid.Health = 100

    npc.PrimaryPart = hrp

    local torso = Instance.new("Part")
    torso.Name = "Torso"
    torso.Size = Vector3.new(2, 2, 1)
    torso.Color = Color3.new(1, 0, 0) -- Red color for visibility
    torso.Parent = npc

    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(1, 1, 1)
    head.Color = Color3.new(1, 0.8, 0.6) -- Skin color
    head.Parent = npc
    
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

    return npc, hrp, humanoid
end

--executions
local npc, hrp, humanoid = createNPC()