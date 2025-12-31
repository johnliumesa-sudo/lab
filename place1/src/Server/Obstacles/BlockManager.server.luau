local blockSize = Vector3.new(4,4,4)
local minGeometries = 2000
local areaSize = 400
local geometriesFolder = Instance.new("Folder")
geometriesFolder.Name = "Geomitries"
geometriesFolder.Parent = workspace
local blockTemplate = Instance.new("Part")
blockTemplate.Size = blockSize
blockTemplate.Anchored = true
blockTemplate.BrickColor = BrickColor.Random()
blockTemplate.Parent = geometriesFolder

local function GetRandomPosition ()
	local x = math.random(-areaSize/2,areaSize/2)
	local z = math.random(-areaSize/2,areaSize/2)
	return Vector3.new(x,0,z)
end

local function generateGeometry()
	local maxBlockHeight = math.random(0,100)
	local height = 0
	local blocks = {}
	local initialPosition = GetRandomPosition()
	
	while height < maxBlockHeight do
		local block = blockTemplate:Clone()
		block.Position = initialPosition + Vector3.new(0,height,0)
		block.Parent = geometriesFolder		
		table.insert(blocks,block)
		height = height + blockSize.Y
		table.insert(blocks,block)
		if math.random() > 0 then
			initialPosition = initialPosition + Vector3.new(blockSize.X * math.random(-1,1),0,blockSize.z * math.random(-1,1))
		end
	end
	for i = 1, #blocks -1 do
		local currentBlock = blocks[i]
		local nextBlock = blocks[1 + 1]
		local stepBlock = blockTemplate:Clone()
		stepBlock.Position = (currentBlock.Position + nextBlock.Position)/2 + 	Vector3.new(0,blockSize.Y/2, 0)
		stepBlock.Parent = geometriesFolder
	end
end

while #geometriesFolder:GetChildren() < minGeometries do
	generateGeometry()
end
