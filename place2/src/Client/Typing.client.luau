local player = game:GetService("Players").LocalPlayer
player.CameraMode = Enum.CameraMode.LockFirstPerson
local WordEvent = game:GetService("ReplicatedStorage"):FindFirstChild("Events"):WaitForChild("WordEvent")
-- Create basic UI via script to keep file count low
local sg = Instance.new("ScreenGui", player.PlayerGui)
local frame = Instance.new("Frame")
frame.BackgroundColor3 = Color3.new(0.152941, 0.784313, 0.117647)
frame.Size = UDim2.new(0, 500, 0, 77)
frame.Position = UDim2.new(0, 0, 0.8, 0)
frame.Parent = sg
local uic = Instance.new("UICorner")
uic.Parent = frame
local tb = Instance.new("TextBox", sg)
tb.Size = UDim2.new(0, 300, 0, 50)
tb.Position = UDim2.new(0, 0, 0.1, 0)
tb.PlaceholderText = "Type the holiday words here..."
tb.ClearTextOnFocus = true
tb.Parent = frame
local uic2 = uic:Clone()
uic2.Parent = tb
tb:CaptureFocus() -- Keep typing for fast gameplay

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
