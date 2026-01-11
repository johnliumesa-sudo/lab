local player = game:GetService("Players").LocalPlayer
player.CameraMode = Enum.CameraMode.LockFirstPerson
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
-- 1. Disable Movement Logic
local playerScripts = player:WaitForChild("PlayerScripts")
local PlayerModule = require(playerScripts:WaitForChild("PlayerModule"))
local controls = PlayerModule:GetControls()
controls:Disable() -- This locks WASD and Arrow Keys
-- 2. Disable Mouse/Clicking Logic
local function sinkInput()
    return Enum.ContextActionResult.Sink
end
ContextActionService:BindAction(
    "DisableMouse",
    sinkInput,
    false,
    Enum.UserInputType.MouseButton1,
    Enum.UserInputType.MouseButton2,
    Enum.UserInputType.Touch,
    Enum.UserInputType.MouseWheel
)
-- 3. Set Camera and Cursor
UserInputService.MouseIconEnabled = true
UserInputService.MouseBehavior = Enum.MouseBehavior.Default
-- Word Event Logic
local WordEvent = game:GetService("ReplicatedStorage"):FindFirstChild("Events"):WaitForChild("WordEvent")
-- UI Creation
local sg = Instance.new("ScreenGui", player.PlayerGui)
local frame = Instance.new("Frame")
frame.BackgroundColor3 = Color3.new(0.152941, 0.784313, 0.117647)
frame.Size = UDim2.new(0, 500, 0, 77)
frame.Position = UDim2.new(0.5, -250, 0.8, 0) -- Centered
frame.Parent = sg
local uic = Instance.new("UICorner")
uic.Parent = frame
local tb = Instance.new("TextBox")
tb.Size = UDim2.new(0.9, 0, 0.6, 0)
tb.Position = UDim2.new(0.05, 0, 0.2, 0)
tb.PlaceholderText = "Type the holiday words here..."
tb.ClearTextOnFocus = true
tb.Parent = frame
local uic2 = uic:Clone()
uic2.Parent = tb
tb:CaptureFocus()

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
