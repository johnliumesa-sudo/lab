local replicatedStorage = game:GetService("ReplicatedStorage")
local dialogChoiceEvent = Instance.new("RemoteEvent")
dialogChoiceEvent.Name = "DialogChoiceEvent"
dialogChoiceEvent.Parent = replicatedStorage
local tradingEvent = Instance.new("RemoteEvent")
tradingEvent.Name = "TradingEvent"
tradingEvent.Parent = replicatedStorage
local displayItemsEvent = Instance.new("RemoteEvent")
displayItemsEvent.Name = "DisplayItemsEvent"
displayItemsEvent.Parent = replicatedStorage
local feedbackMessageEvent = Instance.new("RemoteEvent")
feedbackMessageEvent.Name = "FeedbackMessageEvent"
feedbackMessageEvent.Parent = replicatedStorage
local PlayerFinderEvent = Instance.new("RemoteEvent")
PlayerFinderEvent.Name = "PlayerFinderEvent"
PlayerFinderEvent.Parent = replicatedStorage 
local WireTransferEvent = Instance.new("RemoteEvent")
WireTransferEvent.Name = "WireTransferEvent"
WireTransferEvent.Parent = replicatedStorage
local MoneyReciverEvent = Instance.new("RemoteEvent")
MoneyReciverEvent.Name = "MoneyReciverEvent"
MoneyReciverEvent.Parent = replicatedStorage

-- local npc = workspace.Store:WaitForChild("NPC")
-- local dialog = npc:WaitForChild("Head"):WaitForChild("Dialog")
local depreciationRate = 0.5

local function onDialog(player)
    --   print(player.Name.. "selected: " .. choiceName)
    --   local items = {}
    --   local itemsData = {}
    --   if choiceName == "Buy" then
	  --       items = itemsFolder:GetChildren()
	  --       print(items)
    --   elseif  choiceName == "Sell"  then
	  --       items = player.Backpack:GetChildren()
    --   end
    --   for _, item in ipairs(items) do
	  --       local config = item:FindFirstChild("Configuration")
	  --       if config and config:FindFirstChild("BuyPrice") then
	  -- 	      local buyPrice = config.BuyPrice.Value
	  -- 	      local sellPrice = math.round(buyPrice * depreciationRate) 
	  -- 	  table.insert(itemsData, {Name = item.Name, BuyPrice = buyPrice , SellPrice = sellPrice})
	  --       end
    --   end
    --   print(itemsData)
    --   print( "test from aaron")
    --   displayItemsEvent:FireClient(player, itemsData, choiceName)
	displayItemsEvent:FireClient(player, "Server got your message!")
end

local function onTrading(player, itemName, choiceName)
    --   local playerStats = player:WaitForChild("leaderstats")
    --   if playerStats then
	  --       local coins = playerStats:FindFirstChild("Coin")
	  --       local item = itemsFolder:FindFirstChild(itemName)
	  --       if coins and item then
	  -- 	      local config = item:FindFirstChild("Configuration")
	  -- 	      if config and config:FindFirstChild("BuyPrice") then
	  -- 		      local buyPrice = config.BuyPrice.Value
	  -- 		      local sellPrice = math.round(buyPrice * depreciationRate)
	  -- 		      if choiceName == "Buy" then
	  -- 			      if coins.Value >= buyPrice then
	  -- 				      coins.Value = coins.Value - buyPrice
	  -- 				      local itemClone = item:Clone()
	  -- 				      itemClone.Parent = player.Backpack
	  -- 				      print(player.name .. " purchased " .. itemName " for " .. buyPrice)
	  -- 			      end
	  -- 		      end
	  -- 	      end
	  --       else
	  -- 	      warn("coins or items not found!")
	  --       end
    --   end
end

dialogChoiceEvent.OnServerEvent:Connect(onDialog)
--tradingEvent.onServerEvent:Connect(onTrading)
