local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local item = ReplicatedStorage:WaitForChild("Collectables"):WaitForChild("Items"):WaitForChild("Part")
local itemsFolder = Workspace:WaitForChild("Collectables"):WaitForChild("Items")
local spawnRange = 48
local itemCount = 100 -- Updated to match the word list size
local Words = {
   "snow", "bell", "star", "gift", "tree", "deer", "sled", "noel", "cold", "home",
   "joy", "hope", "love", "calm", "kind", "wish", "yule", "pine", "fire", "gold",
   "holly", "merry", "jolly", "candy", "cane", "frost", "santa", "elves", "sleigh", "light",
   "winter", "spirit", "giving", "cheer", "bright", "peace", "praise", "glory", "wonder", "magic",
   "gingy", "baking", "cookie", "cocoa", "coffee", "snacks", "feasting", "family", "friends", "church",
   "chimney", "stocking", "reindeer", "rudolph", "dasher", "dancer", "prancer", "vixen", "comet", "cupid",
   "donner", "blitzen", "workshop", "northpole", "icecap", "glacier", "iceberg", "snowman", "igloo", "mittens",
   "scarf", "jumper", "sweater", "blanket", "earmuffs", "tinsel", "wreath", "bauble", "ornaments", "garland",
   "carols", "hymns", "music", "singing", "dance", "parties", "games", "laughter", "smiling", "hugger",
   "ribbon", "wrappings", "parcel", "boxed", "surprise", "kindness", "items", "tradition", "believer"
}
local Colors = {
   Color3.new(1, 0, 0),    -- Red
   Color3.new(0, 1, 0),    -- Green
   Color3.new(1, 1, 1),    -- White
   Color3.new(1, 0.84, 0), -- Gold
   Color3.new(0, 0.75, 1)  -- Ice Blue
}

local WordEvent = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("WordEvent")
local function onWordTyped(player, typedWord)
   -- Loop through all spawned items in the Workspace
   for _, item in pairs(itemsFolder:GetChildren()) do
      -- Compare typed text to the name assigned during createLabel
      if item.Name:lower() == typedWord:lower() then
	 -- Award points (using logic from your ItemScript)
	 local leaderstats = player:FindFirstChild("leaderstats")
	 if leaderstats then
	    leaderstats.CoinCount.Value += 50
	 end
	 -- Visual feedback or simple destruction
	 item:Destroy()
	 print("Match found! Item " .. typedWord .. " collected by " .. player.Name)
	 break -- Only destroy one match per type
      end
   end
end

local function createLabel(parentPart)
   local billboard = Instance.new("BillboardGui")
   billboard.Name = "Label"
   billboard.Size = UDim2.new(0, 150, 0, 50)
   billboard.Adornee = parentPart
   billboard.AlwaysOnTop = true
   billboard.ExtentsOffset = Vector3.new(0, 3, 0)
   billboard.Parent = parentPart
   local label = Instance.new("TextLabel")
   label.Size = UDim2.new(1, 0, 1, 0)
   label.BackgroundTransparency = 1
   label.Font = Enum.Font.Arimo
   label.TextSize = 18
   label.RichText = true
   -- Set random word and random glowing color
   local randomWord = Words[math.random(1, #Words)]
   local chosenColor = Colors[math.random(1, #Colors)]
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
   local zpos = -20
   local ypos = 40
   local itemScript = script.Parent:FindFirstChild("ItemScript")
   local itemClone = item:Clone()
   local itemScriptClone = itemScript:Clone()
   itemScriptClone.Parent = itemClone
   itemClone.Parent = itemsFolder
   itemClone.Position = Vector3.new(xpos, ypos, zpos)
   itemClone.Anchored = false
   createLabel(itemClone)
end

WordEvent.OnServerEvent:Connect(onWordTyped)
for i = 1, itemCount do
   randomSpawn()
   task.wait(3) -- Small delay to prevent frame drops during mass tweening
end
