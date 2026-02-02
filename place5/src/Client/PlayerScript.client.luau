local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
-- Wait for the events to be created by the server script (ToolShopManager)
local dialogChoiceEvent = ReplicatedStorage:WaitForChild("DialogChoiceEvent")
local displayItemsEvent = ReplicatedStorage:WaitForChild("DisplayItemsEvent")

local function onServerResponse(data)
   -- This triggers when the server fires back via displayItemsEvent
	print("recieved request from server.")
   -- You can process the 'data' here (e.g., open a GUI)
end

local function onDialogChoiceSelected(dialog, choice)
   -- Check if the choice is relevant (Buy/Sell)
	if choice.Name == "Buy" or choice.Name == "Sell" then
	   -- Fire the server so it knows what we picked
	      dialogChoiceEvent:FireServer(choice.Name)
	end
end

local function setupDialogListeners()
  -- Look for existing NPCs with Dialogs
	for _, npc in pairs(Workspace:WaitForChild("NPCs"):WaitForChild("Clerks"):GetChildren()) do
	    if npc.Name ~= "Script" then
		local head = npc:WaitForChild("Head")
		local dialog = head:FindFirstChild("Dialog")
		if dialog then
		    dialog.DialogChoiceSelected:Connect(function(player, choice)
		    onDialogChoiceSelected(dialog, choice)
		    end)
		end
	    end
	end
  -- Handle new NPCs added later (if any)
	Workspace.NPCs.Clerks.ChildAdded:Connect(function(npc)
	    local head = npc:WaitForChild("Head")
	    local dialog = head:WaitForChild("Dialog")
	    dialog.DialogChoiceSelected:Connect(function(player, choice)
	    onDialogChoiceSelected(dialog, choice)
	    end)
	end)
end

-- Connect the listener for the server response
   displayItemsEvent.OnClientEvent:Connect(onServerResponse)
-- Initialize listeners for Dialog interactions
   setupDialogListeners()
