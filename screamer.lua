function screamer_init()
  screamer = {
    elapsedTime = 0,
    displayDuration = 2,
    showImage = true,
    alpha = 0,
    lastTile = nil
  }

  screamer.images = {
    love.graphics.newImage("assets/screamers/screamer_1.png"),
    love.graphics.newImage("assets/screamers/screamer_2.png"),
    love.graphics.newImage("assets/screamers/screamer_3.png"),
  }

    screamer_sound = love.audio.newSource("assets/sounds/sound.wav", "stream")
end

function screamer_update(dt)
  screamer.elapsedTime = screamer.elapsedTime + dt
  if screamer.elapsedTime >= screamer.displayDuration then
    screamer.showImage = false
  end

  local tile = dungeon_get_tile(player.x, player.y)

  if tile == 2 or tile == 3 or tile == 4 then
    if screamer.lastTile ~= tile then
      screamer.lastTile = tile
      screamer.elapsedTime = 0
      screamer.showImage = true
      screamer.alpha = 1
      love.audio.play(screamer_sound)
    end
  else
    screamer.lastTile = nil
  end
end

function screamer_draw()
  local scale = 1.5
  local rotate = 0
  local originX = 200
  local originY = 300
  if screamer.showImage and screamer.lastTile then
    local image = screamer.images[screamer.lastTile - 1]
    love.graphics.setColor(1, 1, 1, screamer.alpha)
    love.graphics.draw(image, screenW / 2, screenH / 2, rotate, scale, scale, originX, originY)
  end
end
