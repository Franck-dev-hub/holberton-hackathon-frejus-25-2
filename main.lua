-- Disable scale smoothing
love.graphics.setDefaultFilter("nearest")

-- Imports
local sceneDungeon = require("sceneDungeon")
local sceneEditor = require("sceneEditor")

-- Inits
local sceneCurrent = sceneDungeon

-- Load when it's called
function love.load()
	sceneCurrent.load()
end

-- Core update is executed each frame based on dt
function love.update(dt)
	sceneCurrent.update(dt)
end

-- Draw update is executed each frame based on dt
function love.draw(dt)
	love.graphics.scale(2, 2)
	sceneCurrent.draw(dt)
end

-- Is executed each time a key is pressed
function love.keypressed(key)
	if key == "escape" then
		if sceneCurrent == sceneEditor then
			sceneCurrent = sceneDungeon
		else
			sceneCurrent = sceneEditor
		end
	end

	sceneCurrent.keypressed(key)
end

-- Is executed each time mouse button is pressed
function love.mousepressed(x, y, button, istouch)
	sceneCurrent.mousepressed(x, y , button, istouch)
end
