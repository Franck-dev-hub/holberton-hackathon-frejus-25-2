-- Global vars
screenW, screenH = 800, 600

-- Load requirements
require("player")
require("dungeon")
require("raytracing")
require("screamer")
require("input")

function love.load()
  love.window.setMode(800, 600, {
    fullscreen = false,
    vsync = 1,
    resizable = false
  })
  love.window.setTitle("Dungeon Crawler")
  
  player_init()
  dungeon_init()
  screamer_init()
  raytracing_init()
end

function love.update(dt)
  screamer_update(dt)
end

function love.draw()
  raytracing_draw()
  screamer_draw()
end

function love.keypressed(key)
  input_keypressed(key)
end
