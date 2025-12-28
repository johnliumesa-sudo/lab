if script.Parent.Parent == game:GetService("Workspace"):FindFirstChild("NPCs") :FindFirstChild("Clerks") then 
    local npc = script.Parent 
    local dialog = Instance.new("Dialog")
    dialog.BehaviorType = Enum.DialogBehaviorType.MultiplePlayers
    dialog.InitialPrompt = "Welcome to Aaron's Tool and Gadgets! I am Mac. "
    dialog.Parent = npc.Head
    local buyChoice = Instance.new("DialogChoice")
    buyChoice.UserDialog = "I want to buy a tool"
    buyChoice.ResponseDialog = "Here are the items available:"
    buyChoice.Name = "Buy"
    buyChoice.Parent = dialog 
    local sellChoice = Instance.new("DialogChoice")
    sellChoice.UserDialog = "I want to sell some items."
    sellChoice.ResponseDialog = "Ok, which items do you want to sell? "
    sellChoice.Name = "Sell"
    sellChoice.Parent = dialog
end
