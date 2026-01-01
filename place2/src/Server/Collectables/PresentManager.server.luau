local present = game:GetService("ReplicatedStorage"):FindFirstChild("Collectables"):FindFirstChild("Presents"):WaitForChild("Part")
local presentScript = script.Parent:FindFirstChild("PresentScript")
presentScript.Parent = present
local presentsFolder = game:GetService("Workspace"):FindFirstChild("Collectables"):FindFirstChild("Presents")
local spawnRange = 48
local presentCount = 6
local holidayWords = {"Merry", "Jolly", "Peace", "Giving", "Cheer", "Bright", "Spirit", "Holiday"}

local function createHolidayLabel(parentPart)
   local billboard = Instance.new("BillboardGui")
   billboard.Name = "HolidayLabel"
   billboard.Size = UDim2.new(0, 200, 0, 50)
   billboard.Adornee = parentPart
   billboard.AlwaysOnTop = true
   billboard.ExtentsOffset = Vector3.new(0, 3, 0) -- Positioned above the present
   billboard.Parent = parentPart
   local label = Instance.new("TextLabel")
   label.Size = UDim2.new(1, 0, 1, 0)
   label.BackgroundTransparency = 1
   label.TextColor3 = Color3.new(1, 1, 1) -- White text
   label.TextStrokeTransparency = 0 -- Black outline for readability
   label.Font = Enum.Font.LuckiestGuy
   label.TextSize = 24
   -- Pick a random word
   label.Text = holidayWords[math.random(1, #holidayWords)]
   label.Parent = billboard
   return billboard
end

local function randomSpawn()
  local xpos = math.random (-spawnRange, spawnRange)
  local zpos = math.random (-spawnRange, spawnRange)
  local ypos = 3
  local present = game:GetService("ReplicatedStorage"):FindFirstChild("Collectables"):FindFirstChild("Presents"):WaitForChild("Part")
  local presentClone = present:Clone()
  presentClone.Parent = presentsFolder
  presentClone.Position = Vector3.new(xpos,ypos,zpos)
  createHolidayLabel(presentClone)
  return
end

for i = 1, presentCount do
    randomSpawn()
end
