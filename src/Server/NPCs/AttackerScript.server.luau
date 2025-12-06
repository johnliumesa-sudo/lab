local StartingPosition = Vector3.new(0, 5, 0)
local Players = game:GetService("Players")
local targetDistance = math.random(50, 60)
local refreshRate = 0.001
local pathFindingService = game:GetService("PathfindingService")
local stopDistance = 3
local debris = game:GetService("Debris")

local function handleObstacle(rigRootPart)
  local humanoid = rigRootPart.Parent:FindFirstChild("Humanoid")
  if humanoid then
      -- Force the jump state
      humanoid.Jump = true
      humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
  end
end

local function checkForObstacles(rigRootPart)
  -- Look forward relative to the HRP
  local origin = rigRootPart.Position
  local direction = rigRootPart.CFrame.LookVector * 4 -- Check 4 studs ahead
  local rayParams = RaycastParams.new()
  rayParams.FilterDescendantsInstances = {rigRootPart.Parent} -- Ignore self
  rayParams.FilterType = Enum.RaycastFilterType.Exclude
  local rayResult = workspace:Raycast(origin, direction, rayParams)
  if rayResult and rayResult.Instance then
      -- If we hit a part that is CanCollide (a wall/block), Jump!
      if rayResult.Instance.CanCollide then
	  handleObstacle(rigRootPart)
      end
  end
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
	 if distance <= stopDistance then
	    if waypoint.Action == Enum.PathWaypointAction.Jump then
	       rigHumanoid.JumpHeight = 7.2
	       rigHumanoid.Jump = true
	    end
	    checkForObstacles(targetPosition, rigRootPart)
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
    torso.Color = Color3.new(1, 0, 0) -- Red color for visibility(Kill)
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
  if character and character:IsA("Model") then
      local humanoid = character:FindFirstChildWhichIsA("Humanoid")
      if humanoid then
	  local player = Players:GetPlayerFromCharacter(character)  -- Character's parent is the Player
	  if player then
	      script.Parent:FindFirstChild("HumanoidRootPart").CanTouch = false
	      script.Parent:FindFirstChild("Torso").Color = Color3.new(0.152941, 0.784313, 0.117647) 
	      humanoid.BreakJointsOnDeath = false
	      humanoid.Health = 0
	      task.wait(5)
	      script.Parent:FindFirstChild("Torso").Color = Color3.new(1, 0, 0)
	      script.Parent:FindFirstChild("HumanoidRootPart").CanTouch = true 
	  end
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

local function getClosestPlayer(rigRootPart)
    local closestPlayer = nil
    local closestDistance = math.huge
    for _, player in ipairs(Players:GetPlayers()) do
  	      local character = player.Character
  	      if character and character:FindFirstChild("HumanoidRootPart") then
  		      local distance = (character.HumanoidRootPart.Position - rigRootPart.Position).Magnitude
  		      if distance < closestDistance then
  		      closestDistance = distance
  		      closestPlayer = player
  		      print("Found a player at distance:", closestDistance)
  		      end
  	      end
    end
    return closestPlayer, closestDistance
end

createAttacker()
if script.Parent.Parent == game.Workspace:FindFirstChild("NPCs"):FindFirstChild("Attackers") then
   script.Parent:FindFirstChild("HumanoidRootPart").Touched:Connect(onTouched)     
   local rigRootPart = script.Parent:FindFirstChild("HumanoidRootPart")
   -- task.spawn(movement)
   while true do
      local closestPlayer, closestDistance = getClosestPlayer(rigRootPart)
      if closestPlayer and closestPlayer.Character then
	 local playerRootPart = closestPlayer.Character:WaitForChild("HumanoidRootPart")
	 if closestDistance <= targetDistance then
	    moveToPlayer(playerRootPart, rigRootPart)
	 end
      end
      task.wait(refreshRate)
   end
end
