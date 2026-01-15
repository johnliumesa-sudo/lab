local player = game:GetService("Players").LocalPlayer
local WordEvent = game:GetService("ReplicatedStorage"):FindFirstChild("Events"):WaitForChild("WordEvent")
--player.CameraMode = Enum.CameraMode.LockFirstPerson
-- Create basic UI via script to keep file count low
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
-- Disable Movement Logic
local playerScripts = player:WaitForChild("PlayerScripts")
local PlayerModule = require(playerScripts:WaitForChild("PlayerModule"))
local controls = PlayerModule:GetControls()
controls:Disable() -- This locks WASD and Arrow Keys
-- Set Camera and Cursor
UserInputService.MouseIconEnabled = true
UserInputService.MouseBehavior = Enum.MouseBehavior.Default
local sg = Instance.new("ScreenGui", player.PlayerGui)
local frame = Instance.new("Frame")
frame.BackgroundColor3 = Color3.new(0.152941, 0.784313, 0.117647)
frame.Size = UDim2.new(0, 500, 0, 50)
frame.Position = UDim2.new(0.5, -150, 0.8, 0)
frame.Parent = sg
local tb = Instance.new("TextBox", sg)
tb.Size = UDim2.new(0, 300, 0, 50)
tb.Position = UDim2.new(0.5, -150, 0.8, 0)
tb.PlaceholderText = "Type the holiday words here..."
tb.ClearTextOnFocus = true
tb.Parent = frame

local function sinkInput()
    return Enum.ContextActionResult.Sink
end

-- Disable Mouse/Clicking Logic
	ContextActionService:BindAction(
	    "DisableMouse",
	    sinkInput,
	    false,
	    Enum.UserInputType.MouseButton1,
	    Enum.UserInputType.MouseButton2,
	    Enum.UserInputType.Touch,
	    Enum.UserInputType.MouseWheel,
	    Enum.UserInputType.MouseMovement
	)
-- Input handler
	tb.InputEnded:Connect(function(input)
	    if input.UserInputType == Enum.UserInputType.Keyboard then
		if input.KeyCode == Enum.KeyCode.Return then
		    WordEvent:FireServer(tb.Text)
		    tb.Text = "" -- Reset box
		    tb:CaptureFocus() -- Keep typing for fast gameplay
		else
		    return
		end
	    else
		return
	    end
	end)
