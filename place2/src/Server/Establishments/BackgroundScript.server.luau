local frontWall = Instance.new("Part")
frontWall.Name = "frontWall"
frontWall.Size = Vector3.new(48,48,2)
frontWall.Position = Vector3.new(0,36,40)
local wallFolder = Instance.new("Folder")
wallFolder.Parent = game:GetService("Workspace")
wallFolder.Name = "Walls"
frontWall.Parent = wallFolder
local wallpaper = Instance.new("Decal")
wallpaper.Texture = "http://www.roblox.com/asset/?id=5993087930"
wallpaper.Parent = frontWall
wallpaper.Face = Enum.NormalId.Front


