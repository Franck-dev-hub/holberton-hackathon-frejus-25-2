-- Module creation
local dungeon = {}

-- Variables
local map = {}
dungeon.width = 0
dungeon.height = 0

-- Player directions
dungeon.NORTH = 1
dungeon.EAST = 2
dungeon.SOUTH  = 3
dungeon.WEST = 4

-- Player position
dungeon.playerX = 0
dungeon.playerY = 0
dungeon.playerDirection = 0

-- Load arrow's images
local imgNORTH = love.graphics.newImage("assets/arrows/north.png")
local imgSOUTH = love.graphics.newImage("assets/arrows/south.png")
local imgEAST = love.graphics.newImage("assets/arrows/east.png")
local imgWEST = love.graphics.newImage("assets/arrows/west.png")

-- Load screamer images
local image_1 = love.graphics.newImage("assets/screamers/screamer_1.png")
local image_2 = love.graphics.newImage("assets/screamers/screamer_2.png")
local image_3 = love.graphics.newImage("assets/screamers/screamer_3.png")

-- Graphic variables
local screenW, screenH = love.graphics.getWidth(), love.graphics.getHeight()
local rayCount = 200
local maxDist = 8

-- Screamer state
local elapsedTime = 0
local displayDuration = 0.2
local showImage = false
local screamerAlpha = 0
local lastScreamerTile = nil

-- Load the dungeon
function dungeon.load()
	-- Game parameters
	love.window.setMode(0, 0, {
		fullscreen = true,
		fullscreentype = "desktop",
		vsync = 1,
		resizable = false
	})
	love.window.setTitle("Dungeon Crawler")
	screenW, screenH = love.graphics.getDimensions()

	map = {
		{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
		{1,0,0,0,0,2,0,0,1,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1},
		{1,1,1,1,1,0,1,0,1,0,1,0,1,0,1,0,1,1,1,1,1,0,1,1,1,0,1,1,1,0,1},
		{1,0,0,0,0,0,1,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,1,0,1,0,0,0,0,0,1},
		{1,0,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1},
		{1,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,1},
		{1,0,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,0,1},
		{1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,1},
		{1,0,1,0,1,0,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,0,1,0,1,0,1,0,1},
		{1,0,1,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,1,0,1},
		{1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,0,1,0,1},
		{1,0,0,0,1,0,0,0,0,0,1,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,1,0,1,0,1},
		{1,0,1,1,1,0,1,1,1,1,1,0,1,0,1,0,1,0,1,1,1,1,1,1,1,0,1,1,1,0,1},
		{1,0,0,0,1,0,1,0,0,0,1,0,1,0,1,0,1,0,1,0,0,0,0,0,1,0,0,0,1,0,1},
		{1,0,1,0,1,1,1,0,1,0,1,0,1,0,1,1,1,0,1,0,1,1,1,1,1,1,1,0,1,0,1},
		{1,0,1,0,0,0,1,0,1,0,1,0,1,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1},
		{1,1,1,1,1,0,1,0,1,0,1,1,1,0,1,0,1,1,1,1,1,0,1,0,1,0,1,1,1,1,1},
		{1,0,0,0,0,0,1,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,1},
		{1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,0,1,1,1,0,1,0,1,0,1},
		{1,0,1,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,1,0,1,0,0,0,1,0,0,0,1},
		{1,0,1,0,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,0,1,1,1,0,1,1,1,1,1,0,1},
		{1,0,1,0,1,0,1,0,0,0,1,0,0,0,0,0,1,0,1,0,1,0,0,0,1,0,0,0,1,0,1},
		{1,0,1,0,1,0,1,0,1,0,1,1,1,1,1,0,1,1,1,0,1,0,1,1,1,0,1,0,1,1,1},
		{1,0,1,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,1,0,0,0,1},
		{1,0,1,0,1,1,1,1,1,1,1,0,1,0,1,1,1,0,1,1,1,0,1,1,1,1,1,1,1,0,1},
		{1,0,1,0,1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,1},
		{1,0,1,0,1,0,1,1,1,1,1,1,1,1,1,0,1,1,1,0,1,1,1,1,1,0,1,0,1,0,1},
		{1,0,1,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,1,0,1,0,1},
		{1,0,1,0,1,1,1,0,1,0,1,0,1,0,1,1,1,0,1,1,1,0,1,1,1,1,1,0,1,0,1},
		{1,0,1,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
		{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
	}

	-- Get map size
	dungeon.width = #map[1]
	dungeon.height = #map
	dungeon.sizeCase = 10
end

-- Load player position
function dungeon.changePlayerPosition(x, y, direction)
	dungeon.playerX = x
	dungeon.playerY = y
	dungeon.playerDirection = direction
end

function dungeon.case(row, column)
	return map[row][column]
end

-- Update screamer timing
function dungeon.update(dt)
	elapsedTime = elapsedTime + dt
	if elapsedTime >= displayDuration then
		showImage = false
	end

	-- Check current tile for screamer
	local currentTile = map[dungeon.playerY] and map[dungeon.playerY][dungeon.playerX]

	if currentTile == 2 or currentTile == 3 or currentTile == 4 then
		if lastScreamerTile ~= currentTile then
			-- New screamer tile entered
			lastScreamerTile = currentTile
			elapsedTime = 0
			showImage = true
			screamerAlpha = 1
		end
	else
		lastScreamerTile = nil
	end
end

function draw2D()
	-- Draw map
	for row = 1, dungeon.height do
		for column = 1, dungeon.width do
			local x = (column - 1) * dungeon.sizeCase
			local y = (row - 1) * dungeon.sizeCase
			local case = map[row][column]
			if case == 1 then
				love.graphics.setColor(1, 1, 1)
			else
				love.graphics.setColor(0.3, 0.3, 0.3)
			end
			love.graphics.rectangle("fill", x, y, dungeon.sizeCase, dungeon.sizeCase)
			if row == dungeon.playerY and column == dungeon.playerX then
				love.graphics.setColor(0, 1, 1)
				-- Draw image in function of the player direction
				if dungeon.playerDirection == dungeon.NORTH then
					love.graphics.draw(imgNORTH, x, y)
				elseif dungeon.playerDirection == dungeon.EAST then
					love.graphics.draw(imgEAST, x, y)
				elseif dungeon.playerDirection == dungeon.SOUTH then
					love.graphics.draw(imgSOUTH, x, y)
				elseif dungeon.playerDirection == dungeon.WEST then
					love.graphics.draw(imgWEST, x, y)
				end
			end
		end
	end
end

local function castRay(angle)
	local worldX = dungeon.playerX - 0.2
	local worldY = dungeon.playerY - 0.2
	local dx, dy = math.cos(angle), math.sin(angle)

	for step = 0, maxDist * 100, 0.05 do
		local x = worldX + dx * step
		local y = worldY + dy * step

		local gridX = math.floor(x)
		local gridY = math.floor(y)

		if gridY < 1 or gridY > #map or gridX < 1 or gridX > #map[1] then
			return step
		end

		if map[gridY + 1] and map[gridY + 1][gridX + 1] == 1 then
			return step
		end
	end

	return maxDist
end

function draw3D()
	love.graphics.setBackgroundColor(0.1, 0.1, 0.1)

	-- Apply additional scale of 2 for 3D rendering (multiply by 2 total)
	love.graphics.push()
	love.graphics.scale(2, 2)

	-- Convert direction to angle (1=North, 2=East, 3=South, 4=West)
	local playerAngle = 0
	if dungeon.playerDirection == dungeon.NORTH then
		playerAngle = -math.pi/2
	elseif dungeon.playerDirection == dungeon.EAST then
		playerAngle = 0
	elseif dungeon.playerDirection == dungeon.SOUTH then
		playerAngle = math.pi/2
	elseif dungeon.playerDirection == dungeon.WEST then
		playerAngle = math.pi
	end

	-- Raytracing rendering
	-- Use half dimensions since we're scaling by 2x (global scale * 2 = 4x total, so divide by 2)
	local renderW = screenW / 2
	local renderH = screenH / 2
	local fov = math.pi / 4
	for i = 0, rayCount - 1 do
		local rayAngle = playerAngle - fov/2 + (i / rayCount) * fov
		local dist = castRay(rayAngle)

		local x = (i / rayCount) * renderW
		local wallHeight = math.max(10, (renderH / (dist + 0.1)))
		local brightness = math.max(0.2, 1 - dist / maxDist)

		-- Wall
		love.graphics.setColor(0.3 * brightness, 0.2 * brightness, 0.25 * brightness)
		love.graphics.rectangle("fill", x, renderH/2 - wallHeight/2, renderW/rayCount + 1, wallHeight)

		-- Floor
		love.graphics.setColor(0.1, 0.1, 0.1)
		love.graphics.rectangle("fill", x, renderH/2 + wallHeight/2, renderW/rayCount + 1, renderH/2 - wallHeight/2)

		-- Ceiling
		love.graphics.setColor(0.1, 0.1, 0.15)
		love.graphics.rectangle("fill", x, 0, renderW/rayCount + 1, renderH/2 - wallHeight/2)
	end

	-- Draw screamer image
	if showImage then
		local image = nil

		if map[dungeon.playerY] and map[dungeon.playerY][dungeon.playerX] == 2 then
			image = image_1
		elseif map[dungeon.playerY] and map[dungeon.playerY][dungeon.playerX] == 3 then
			image = image_2
		elseif map[dungeon.playerY] and map[dungeon.playerY][dungeon.playerX] == 4 then
			image = image_3
		end

		if image then
			local scale = renderW / image:getWidth()
			love.graphics.setColor(1, 1, 1, screamerAlpha)
			love.graphics.draw(image, renderW/2, renderH/2, 0, scale, scale, image:getWidth()/2, image:getHeight()/2)
		end
	end

	-- Restore previous transformation
	love.graphics.pop()
end

function dungeon.changeCase(row, column, value)
	map[row][column] = value
end

-- Draw the dungeon
function dungeon.draw(dt, mode)
	love.graphics.setBackgroundColor(0.5, 0.5, 0.5)
	if mode == "2D" then
		draw2D()
	elseif mode == "3D" then
		draw3D()
	end
end

-- Return module
return dungeon
