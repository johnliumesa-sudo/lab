local baseplate = game:GetService("Workspace"):FindFirstChild("Baseplate")
baseplate.Material = Enum.Material.Limestone
baseplate.Color = Color3.new(0.670588, 0.745098, 0.670588)
local texture = baseplate:WaitForChild("Texture")
texture:Destroy()
