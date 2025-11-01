-- Module creation
local sceneEditor = {}

local dungeon = require("dungeon")
local sceneDungeon = require("sceneDungeon")

-- Load editor scene
function sceneEditor.load()
	dungeon.load()
end

-- Update editor scne
function sceneEditor.update(dt)
end

-- Draw editor scene
function sceneEditor.draw(dt)
	dungeon.draw(dt, "2D")
end

-- Keyboard management
function sceneEditor.keypressed(key)
	-- Fetch move commands
	sceneDungeon.keypressed(key)
	-- Save map
	if key == "s" then
		local chain = ""
		for row = 1, dungeon.height do
			for column = 1, dungeon.width do
				chain = chain .. dungeon.case(row, column)
				if column < dungeon.width then
					chain = chain .. ","
				end
			end
			chain = chain .. "\n"
			love.filesystem.write("dungeon.csv", chain)
		end
	elseif key == "r" then
		local chain = love.filesystem.read("dungeon.csv")
		local row, column = 1, 1
		local number = ""

		for i = 1, #chain do
			local char = string.sub(chain, i, i)
			if char == "," or char == "\n" then
				if number ~= "" then
					dungeon.changeCase(row, column, tonumber(number))
					number = ""
					column = column + 1
					if column > dungeon.width then
						column = 1
						row = row + 1
					end
				end
			else
				number = number .. char
			end
		end
	end
end

-- Mouse management
function sceneEditor.mousepressed(x, y, button, istouch)
    -- Transpose mouse position because of the scale
    x = x / 2
    y = y / 2
 
    -- Get position
    if button == 1 then
        local row = math.floor(y / dungeon.sizeCase) + 1
        local column = math.floor(x / dungeon.sizeCase) + 1
        -- Switch value
        if dungeon.case(row, column) == 1 then
            dungeon.changeCase(row, column, 0)
        else
            dungeon.changeCase(row, column, 1)
        end
    end
end

-- Module return
return sceneEditor
