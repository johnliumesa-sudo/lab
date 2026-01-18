local baseplate = game:GetService("Workspace"):FindFirstChild("Baseplate")
baseplate.Material = Enum.Material.Grass
baseplate.Color = Color3.new(0, 0.7, 0)
local texture = baseplate:WaitForChild("Texture")
texture:Destroy()
