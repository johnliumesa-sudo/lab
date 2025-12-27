local cloakBase = Instance.new("Tool")
cloakBase.Parent =  game:GetService("ReplicatedStorage"):FindFirstChild("Tools"):FindFirstChild("Cloaks")
local cloakHandle = Instance.new("Part")
cloakHandle.Parent =  cloakBase
cloakHandle.Name = "Handle"
local cloak = Instance.new ("SpecialMesh")
cloak.Parent = cloakHandle
cloak.MeshId = "rbxassetid://12264149190"
cloak.TextureId = "rbxassetid://16606141"
local rotationRate = 3
local Players = game:GetService("Players")
local cloakFolder = game:GetService("Workspace"):FindFirstChild("Tools"):FindFirstChild("Cloaks")

local function onActivated(character)
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then
          if part.Name ~= "HumanoidRootPart" then
            if part.Transparency > 0 then
              part.Transparency = 0
            else
              part.Transparency = 1
              if part:IsA("MeshPart") or part:IsA("Part") then
                part.CanTouch = false
              end
            end  
          end
        end
    end
end

local function onEquipped()
    local character = script.Parent.Parent
    if script.parent:FindFirstChild("Handle") then
       script.parent:FindFirstChild("Handle").Anchored = false
    end
    task.wait(1)
    script.Parent.Activated:Connect(onActivated(character))
end

if script.Parent.Parent == cloakFolder then
  script.Parent.Equipped:Connect(onEquipped)
end

if script.Parent.Parent:IsA("Model") then
  local character = script.Parent.Parent
  script.Parent.Activated:Connect(onActivated(character))
end