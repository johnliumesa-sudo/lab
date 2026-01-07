local player = game:GetService("Players").LocalPlayer
local WordEvent = game:GetService("ReplicatedStorage"):FindFirstChild("Events"):WaitForChild("WordEvent")
-- Create basic UI via script to keep file count low
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

tb.InputBegan:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.Keyboard then
	    if input.KeyCode == Enum.KeyCode.Return then
	WordEvent:FireServer(player, tb.Text)
	tb.Text = "" -- Reset box
	tb:CaptureFocus() -- Keep typing for fast gameplay
	end
  end
end)
