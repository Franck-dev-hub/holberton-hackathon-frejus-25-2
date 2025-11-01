function raytracing_init()
  rayStep = 0.001
  rayCount = 500
  maxDist = 5
end

function raytracing_draw()
  love.graphics.setBackgroundColor(0.1, 0.1, 0.1)

  -- Raytracing rendering
  local fov = math.pi / 4
  for i = 0, rayCount - 1 do
    local rayAngle = player.angle - fov/2 + (i / rayCount) * fov
    local dist = castRay(rayAngle)

    local x = (i / rayCount) * screenW
    local wallHeight = math.max(10, (screenH / (dist + 0.1)))
    local brightness = math.max(0.2, 1 - dist / maxDist)

    -- Wall
    love.graphics.setColor(0.3 * brightness, 0.2 * brightness, 0.25 * brightness)
    love.graphics.rectangle("fill", x, screenH/2 - wallHeight/2, screenW/rayCount + 1, wallHeight)

    -- Floor
    love.graphics.setColor(0.1, 0.1, 0.1)
    love.graphics.rectangle("fill", x, screenH/2 + wallHeight/2, screenW/rayCount + 1, screenH/2 - wallHeight/2)

    -- Ceiling
    love.graphics.setColor(0.1, 0.1, 0.15)
    love.graphics.rectangle("fill", x, 0, screenW/rayCount + 1, screenH/2 - wallHeight/2)
  end

  -- Draw screamer images
  if showImage then
    local gridX = math.floor(player.x) + 1
    local gridY = math.floor(player.y) + 1
    local image = nil

    if dungeon[gridY] and dungeon[gridY][gridX] == 2 then
      image = image_1
      love.audio.play(sound_1)
    elseif dungeon[gridY] and dungeon[gridY][gridX] == 3 then
      image = image_2
      love.audio.play(sound_2)
    elseif dungeon[gridY] and dungeon[gridY][gridX] == 4 then
      image = image_3
      love.audio.play(sound_3)
    end

    if image then
      local scale = 1
      love.graphics.setColor(1, 1, 1, screamerAlpha)
      love.graphics.draw(image, screenW/2, screenH/2, 0, scale, scale, image:getWidth()/2, image:getHeight()/2)
    end
  end
end

function castRay(angle)
  local x, y = player.x, player.y
  local dx, dy = math.cos(angle), math.sin(angle)

  for step = 0, maxDist * rayCount, rayStep do
    x = player.x + dx * step
    y = player.y + dy * step

    if not dungeon_is_walkable(x, y) then
      return step
    end
  end
  return maxDist
end
