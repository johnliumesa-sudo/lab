local eventFolder = Instance.new("Folder")
eventFolder.Name = "EventFolder123"
eventFolder.Parent = game:GetService("ReplicatedStorage")
local event = Instance.new("RemoteEvent")
event.Name = "WordEvent"
event.Parent = eventFolder
