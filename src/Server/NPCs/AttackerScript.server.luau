local StartingPosition = Vector3.new(0, 5, 0)
local Players = game:GetService("Players")
local targetDistance = math.random(50, 60)
local refreshRate = 0.001
local pathFindingService = game:GetService("PathfindingService")
local stopDistance = 3
local debris = game:GetService("Debris")

local function handleObstacle(startPosition, targetPosition, rigRootPart)
   local rigHumanoid = rigRootPart.Parent:FindFirstChild("Humanoid")
    for i = 1, 50 do
      rigHumanoid.Jump = true
      task.wait(0.1)
    end	
    local alternativeAngles = {
    CFrame.Angles(0, math.rad(90), 0),
    CFrame.Angles(0, math.rad(-90), 0),
    CFrame.Angles(0, math.rad(135), 0),
    CFrame.Angles(0, math.rad(180), 0)
    }
    for _, angle in ipairs(alternativeAngles) do
      local baseDirection = (targetPosition - rigRootPart.Position).Unit
      local rotatedDirection = (angle * CFrame.new(baseDirection)).LookVector
      local newTargetPosition = rigRootPart.Position + rotatedDirection * 15
      rigHumanoid:MoveTo(newTargetPosition)
      rigHumanoid.MoveToFinished:Wait()
      if (rigRootPart.Position - startPosition).Magnitude > 0.5 then
	  break
      end
    end
end

local function checkForObstaclesAndJump(targetPosition, rigRootPart)
    local startPosition = rigRootPart.Position
    local moveTimeout = 1
    local reached = false
    task.spawn(function()
	local elapsed = 0
	while elapsed < moveTimeout do
	    task.wait(0.1)
	    elapsed += 0.1
	    if (rigRootPart.Position - startPosition).Magnitude > 0.5 then
		reached = true
		break
	    end
	end
	if not reached then
	    local direction = (targetPosition - rigRootPart.Position).Unit
	    local rayParams = RaycastParams.new()
	    rayParams.FilterDescendantsInstances = {rigRootPart}
	    rayParams.FilterType = Enum.RaycastFilterType.Exclude
	    local rayResult = workspace:Raycast(rigRootPart.Position, direction * 3, rayParams)
	    if rayResult and rayResult.Instance then
	      handleObstacle(startPosition, targetPosition, rigRootPart)
	    end
	end
    end)
end

local function CheckDistance(playerRootPart, rigRootPart)
    return (playerRootPart.Position - rigRootPart.Position).Magnitude
end

local function visualizePath(waypoint)
    local part = Instance.new("Part")
    part.Position = waypoint.Position
    part.Size = Vector3.new(0.5, 0.5, 0.5)
    part.Color = Color3.new(0, 0, 0)
    part.Anchored = true
    part.CanCollide = false
    part.Parent = workspace
    debris:AddItem(part, 0.1)
end

local function moveToPlayer(playerRootPart, rigRootPart)
   local rigHumanoid = rigRootPart.Parent:FindFirstChild("Humanoid")
   local path = pathFindingService:CreatePath({
	 AgentRadius = 0.1,
	 AgentHeight = 0.1,
	 AgentCanJump = true,
	 AgentCanClimb = true,
	 AgentJumpHeight = 7.2,
	 AgentMaxSlope = 89,
	 WaypointSpacing = 1,
	 Costs = { plastic = 3 }
   })
   local success, errorMessage = pcall(function()
	 path:ComputeAsync(rigRootPart.Position, playerRootPart.Position)
   end)     
   if success and path.Status == Enum.PathStatus.Success then
      for _, waypoint in pairs(path:GetWaypoints()) do
	 visualizePath(waypoint)
	 local distance = CheckDistance(playerRootPart, rigRootPart)
	 local targetPosition = (distance <= stopDistance)
	    and playerRootPart.Position + (rigRootPart.Position - playerRootPart.Position).Unit * stopDistance
	    or waypoint.Position
	 rigHumanoid:MoveTo(targetPosition)
	 -- if distance > stopDistance and not walkAnimation.IsPlaying then
	 --     idleAnimation:Stop()
	 --     walkAnimation:Play()
	 --     local runningSound = rigRootPart:FindFirstChild("Running")
	 --     if runningSound then 
	 --         runningSound:Play() 
	 --     end
	 -- end
	 if distance <= stopDistance then
	    -- if walkAnimation.IsPlaying then
	    --     walkAnimation:Stop(0)
	    --     local runningSound = rigRootPart:FindFirstChild("Running")
	    --     if runningSound then runningSound:Stop() end
	    -- end
	    if waypoint.Action == Enum.PathWaypointAction.Jump then
	       rigHumanoid.JumpHeight = 7.2
	       rigHumanoid.Jump = true
	    end
	    checkForObstaclesAndJump(targetPosition, rigRootPart)
	    -- if not idleAnimation.IsPlaying then
	    --     idleAnimation:Play()
	    -- end
	    rigRootPart.CFrame = CFrame.lookAt(rigRootPart.Position, playerRootPart.Position)
	 end
      end
   else
      warn("-ErRoR 403: Pathfinding failed -")
   end
end

local function createAttacker()
    local attacker = Instance.new("Model")
    attacker.Parent = game:GetService("ReplicatedStorage"):FindFirstChild("NPCs"):FindFirstChild("Attackers")
    local hrp = Instance.new("Part")
    hrp.Name = "HumanoidRootPart"
    hrp.Size = Vector3.new(2, 2, 1)
    hrp.Transparency = 1
    hrp. CFrame = CFrame.new(StartingPosition)
    hrp.Anchored = false
    hrp.Parent = attacker
    hrp.CanCollide = true
    local humanoid = Instance.new("Humanoid")
    humanoid.Parent = attacker
    humanoid.WalkSpeed = 16
    humanoid.JumpPower = 50
    humanoid.Health = 100
    attacker.PrimaryPart = hrp
    local torso = Instance.new("Part")
    torso.Name = "Torso"
    torso.Size = Vector3.new(2, 2, 1)
    torso.Color = Color3.new(1, 1, 0) -- Red color for visibility
    torso.Parent = attacker
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(1, 1, 1)
    head.Color = Color3.new(1, 0.8, 0.6) -- Skin color
    head.Parent = attacker
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
    return attacker, hrp, humanoid,torso
end

local function onTouched(otherPart)
    local character = otherPart.Parent
    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
    if humanoid then
	local player = Players:GetPlayerFromCharacter(character)  -- Character's parent is the Player
    if player then
	local leaderstats = player:WaitForChild("leaderstats")
	local coinCount = leaderstats:WaitForChild("CoinCount")
	leaderstats.CoinCount.Value -= 3
	script.Parent:FindFirstChild("HumanoidRootPart").CanTouch = false
	script.Parent:FindFirstChild("Torso").Color = Color3.new(0.152941, 0.784313, 0.117647) 
	if coinCount.Value < 0 then
	    humanoid.BreakJointsOnDeath = false
	    humanoid.Health = 0
	    coinCount.Value = 0
	end
	task.wait(5)
	script.Parent:FindFirstChild("Torso").Color = Color3.new(0.666666, 0.023529, 0.921568)
	script.Parent:FindFirstChild("HumanoidRootPart").CanTouch = true 
	end
    end
end

local function movement()
   local humanoid = script.Parent:FindFirstChild("Humanoid")
   local hrp = script.Parent:FindFirstChild("HumanoidRootPart") 
   StartingPosition = hrp.Position    
   while true do
       local randomX = math.random(-50, 50)
       local randomZ = math.random(-50, 50)
       local targetPosition = StartingPosition + Vector3.new(randomX, 0, randomZ)
       humanoid:MoveTo(targetPosition)
       humanoid.MoveToFinished:Wait()
       task.wait(0.1)
   end
end

local function getClosestPlayer()
end

createAttacker()
if script.Parent.Parent == game.Workspace:FindFirstChild("NPCs"):FindFirstChild("Attackers") then
    -- script.Parent:FindFirstChild("HumanoidRootPart").Touched:Connect(onTouched)
    local rigRootPart = script.Parent:FindFirstChild("HumanoidRootPart")
    -- task.spawn(movement)
    while true do
	local closestPlayer, closestDistance = getClosestPlayer()
	if closestPlayer and closestPlayer.Character then
	    local playerRootPart = closestPlayer.Character:WaitForChild("HumanoidRootPart")
	    if closestDistance <= targetDistance then
		moveToPlayer(playerRootPart, rigRootPart)
	    end
	end
	task.wait(refreshRate)
    end
end
