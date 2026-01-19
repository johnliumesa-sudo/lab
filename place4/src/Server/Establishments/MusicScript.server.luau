local SoundService = game:GetService("SoundService")
local music = Instance.new("Sound")
music.Name = "BackgroundMusic"
music.SoundId = "rbxassetid://90221594357314"
music.Volume = 0.5
music.Looped = true
music.Parent = SoundService

-- Ensure the sound plays immediately upon server start
if not music.IsPlaying then
   music:Play()
   task.wait(2)
end
