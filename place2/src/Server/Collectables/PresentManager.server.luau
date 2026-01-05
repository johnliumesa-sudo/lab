local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local present = ReplicatedStorage:WaitForChild("Collectables"):WaitForChild("Presents"):WaitForChild("Part")
local presentsFolder = Workspace:WaitForChild("Collectables"):WaitForChild("Presents")
local spawnRange = 48
local presentCount = 100 -- Updated to match the word list size
local holidayWords = {
   "Snow", "Bell", "Star", "Gift", "Tree", "Deer", "Sled", "Noel", "Cold", "Home",
   "Joy", "Hope", "Love", "Calm", "Kind", "Wish", "Yule", "Pine", "Fire", "Gold",
   "Holly", "Merry", "Jolly", "Candy", "Cane", "Frost", "Santa", "Elves", "Sleigh", "Light",
   "Winter", "Spirit", "Giving", "Cheer", "Bright", "Peace", "Praise", "Glory", "Wonder", "Magic",
   "Gingy", "Baking", "Cookie", "Cocoa", "Coffee", "Snacks", "Feasting", "Family", "Friends", "Church",
   "Chimney", "Stocking", "Reindeer", "Rudolph", "Dasher", "Dancer", "Prancer", "Vixen", "Comet", "Cupid",
   "Donner", "Blitzen", "Workshop", "Northpole", "Icecap", "Glacier", "Iceberg", "Snowman", "Igloo", "Mittens",
   "Scarf", "Jumper", "Sweater", "Blanket", "Earmuffs", "Tinsel", "Wreath", "Bauble", "Ornaments", "Garland",
   "Carols", "Hymns", "Music", "Singing", "Dance", "Parties", "Games", "Laughter", "Smiling", "Hugger",
   "Ribbon", "Wrappings", "Parcel", "Boxed", "Surprise", "Kindness", "Presents", "Holiday", "Tradition", "Believer"
}
local holidayColors = {
   Color3.new(1, 0, 0),    -- Red
   Color3.new(0, 1, 0),    -- Green
   Color3.new(1, 1, 1),    -- White
   Color3.new(1, 0.84, 0), -- Gold
   Color3.new(0, 0.75, 1)  -- Ice Blue
}

local WordEvent = game:GetService("ReplicatedStorage"):WaitForChild("EventFolder"):WaitForChild("WordEvent")
local function onWordTyped(player, typedWord)
   -- Loop through all spawned presents in the Workspace
   for _, present in pairs(presentsFolder:GetChildren()) do
      -- Compare typed text to the name assigned during createHolidayLabel
      if present.Name:lower() == typedWord:lower() then
	 -- Award points (using logic from your PresentScript)
	 local leaderstats = player:FindFirstChild("leaderstats")
	 if leaderstats then
	    leaderstats.CoinCount.Value += 50
	 end
	 -- Visual feedback or simple destruction
	 present:Destroy()
	 print("Match found! Present " .. typedWord .. " collected by " .. player.Name)
	 break -- Only destroy one match per type
      end
   end
end

local function createHolidayLabel(parentPart)
   local billboard = Instance.new("BillboardGui")
   billboard.Name = "HolidayLabel"
   billboard.Size = UDim2.new(0, 150, 0, 50)
   billboard.Adornee = parentPart
   billboard.AlwaysOnTop = true
   billboard.ExtentsOffset = Vector3.new(0, 3, 0)
   billboard.Parent = parentPart
   local label = Instance.new("TextLabel")
   label.Size = UDim2.new(1, 0, 1, 0)
   label.BackgroundTransparency = 1
   label.Font = Enum.Font.LuckiestGuy
   label.TextSize = 18
   label.RichText = true
   -- Set random word and random glowing color
   local randomWord = holidayWords[math.random(1, #holidayWords)]
   local chosenColor = holidayColors[math.random(1, #holidayColors)]
   label.TextColor3 = chosenColor
   label.TextStrokeColor3 = chosenColor -- Matching stroke for the glow effect
   label.TextStrokeTransparency = 0.5
   label.Text = randomWord
   parentPart.Name = label.Text
   label.Parent = billboard
   -- Create the Glow Animation
   local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
   local goal = {
      TextStrokeTransparency = 0,
      TextSize = 24
   }
   local tween = TweenService:Create(label, tweenInfo, goal)
   tween:Play()
   return billboard
end

local function randomSpawn()
   local xpos = math.random (-spawnRange, spawnRange)
   local zpos = 20
   local ypos = 40
   local presentScript = script.Parent:FindFirstChild("PresentScript")
   local presentClone = present:Clone()
   local presentScriptClone = presentScript:Clone()
   presentScriptClone.Parent = presentClone
   presentClone.Parent = presentsFolder
   presentClone.Position = Vector3.new(xpos, ypos, zpos)
   presentClone.Anchored = false
   createHolidayLabel(presentClone)
end

WordEvent.OnServerEvent:Connect(onWordTyped)
for i = 1, presentCount do
   randomSpawn()
   task.wait(3) -- Small delay to prevent frame drops during mass tweening
end
