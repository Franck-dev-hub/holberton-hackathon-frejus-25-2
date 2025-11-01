-- Module creation
local sceneDungeon = {}

-- Module load
local dungeon = require("dungeon")

-- Load dungeon scene
function sceneDungeon.load()
	dungeon.load() -- Load dungeon
	dungeon.changePlayerPosition(2, 2, dungeon.EAST) -- Init player position
end

-- Update dungeon scene
function sceneDungeon.update(dt)
	dungeon.update(dt)
end

-- Draw dungeon scene
function sceneDungeon.draw(dt)
	dungeon.draw(dt, "3D")
end

-- Keyboard management
function sceneDungeon.keypressed(key)
	local direction = dungeon.playerDirection
	local x = dungeon.playerX
	local y = dungeon.playerY

	-- Turn right management
	if key == "right" or key == "d" then
		direction = direction + 1
		if direction > 4 then
			direction = 1
		end
		dungeon.changePlayerPosition(x, y, direction)
		return
	end

	-- Turn left management
	if key == "left" or key == "q" then
		direction = direction - 1
		if direction == 0 then
			direction = 4
		end
		dungeon.changePlayerPosition(x, y, direction)
		return
	end

	-- Go forward management
	if key == "up" or key == "z" then
		local oldX = x
		local oldY = y

		-- Move forward
		if direction == dungeon.NORTH then
			y = y - 1
		elseif direction == dungeon.EAST then
			x = x + 1
		elseif direction == dungeon.SOUTH then
			y = y + 1
		elseif direction == dungeon.WEST then
			x = x - 1
		end

		-- Wall management
		if dungeon.case(y, x) == 1 then
			x = oldX
			y = oldY
		end
		dungeon.changePlayerPosition(x, y, direction)
	end
end

-- Mouse management
function sceneDungeon.mousepressed(x, y, button, istouch)
end

-- Module return
return sceneDungeon
