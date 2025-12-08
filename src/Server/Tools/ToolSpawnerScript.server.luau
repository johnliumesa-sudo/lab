--This is a tool spawner script which will desplay the tool.
local spawner = Instance.new("Part")
spawner.Shape = Enum.PartType.Cylinder
spawner.Rotation = Vector3.new(0,0,90)
spawner.Size = Vector3.new(3, 2, 3)
spawner.Material = Enum.Material.WoodPlanks
spawner.Color = Color3.new(0.729411, 0.525490, 0.149019)
spawner.Parent = game:GetService("ReplicatedStorage"):FindFirstChild("Tools"):FindFirstChild("ToolSpawners")
local tool = nil
--local region = Region3.new(Vector3.new(spawner.Position.X - 2, spawner.Position.Y, spawner.Position.Z - 2), Vector3.new(spawner.Position.X + spawner.Size.Y/2, spawner.Position.Y + 4, spawner.Position.Z + spawner.Size.Y/2))
local regionCenter = spawner.CFrame + Vector3.new(0, 2, 0)
local parts = game.Workspace:GetPartBoundsInBox(regionCenter,Vector3.new(4,4,4))



for _, part in pairs(parts) do 
	if part and part.Parent and part.Parent:IsA("Tool")then
		tool = part.Parent
	end
end
if tool then
	while true do 
		local toolCopy = tool
		local handle = toolCopy:FindFirstChild("Handle")
		toolCopy.Parent = script.Parent
		local toolOnPad = true
		local parentConnection
		parentConnection = toolCopy.AncestryChanged:Connect(function()
			if handle then 
				handle.Anchored = false
			end
			toolOnPad = false
			parentConnection:Disconnect()
		end)
		if handle then
			handle.CFrame = (spawner.CFrame * CFrame.fromEulerAngles(0,0, math.rad(-90)) + Vector3.new(0, handle.Size.Y * 1.2, 0))
			handle.Anchored = true
		end
		while toolOnPad do 
			if handle then
				handle.CFrame = handle.CFrame * CFrame.Angles( math.pi/60, 0,0)
			end
			task.wait()
		end
		task.wait(60)
	end
end
