local eventFolder = Instance.new("Folder")
eventFolder.Name = "Events"
eventFolder.Parent = game:GetService("ReplicatedStorage")
local event = Instance.new("RemoteEvent")
event.Name = "WordEvent"
event.Parent = eventFolder
