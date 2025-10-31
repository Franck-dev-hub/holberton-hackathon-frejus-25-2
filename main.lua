function love.load()
  -- Game parameters
  screenW, screenH = 800, 600
  love.window.setMode(screenW, screenH)
  love.window.setTitle("Dungeon Crawler")

  -- Player
  player = {
    x = 1.5, y = 1.5,
    angle = 0,
    speed = 4,
    health = 100
  }

  -- Dungeon 1 = wall, 0 = floor, 2 = screamer
  dungeon = {
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
	{1,0,0,0,3,0,0,0,1,0,1,0,0,0,1,2,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1},
	{1,1,1,1,1,0,1,0,1,0,1,0,1,0,1,0,1,1,1,1,1,0,1,1,1,0,1,1,1,0,1},
	{1,0,0,0,0,0,1,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,1,0,1,0,0,0,0,0,1},
	{1,0,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1},
	{1,0,1,0,0,0,1,0,0,0,4,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,1},
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

  rayCount = 120
  maxDist = 10

  -- Images
  image_1 = love.graphics.newImage("assets/screamers/screamer_1.png")
  image_2 = love.graphics.newImage("assets/screamers/screamer_2.png")
  image_3 = love.graphics.newImage("assets/screamers/screamer_3.png")
  
  -- Screamer state
  screamerAlpha = 0
  screamerFadeSpeed = 2
end

function love.update(dt)
  -- Fade out screamer image
  if screamerAlpha > 0 then
    screamerAlpha = math.max(0, screamerAlpha - screamerFadeSpeed * dt)
  end
end

function love.draw()
  love.graphics.setBackgroundColor(0.1, 0.1, 0.1)

  -- Simple raytracing
  local fov = math.pi / 4
  for i = 0, rayCount - 1 do
    local rayAngle = player.angle - fov/2 + (i / rayCount) * fov
    local dist, wallX, wallGridX, wallGridY = castRay(rayAngle)

    local x = (i / rayCount) * screenW
    local wallHeight = math.max(10, (screenH / (dist + 0.1)))
    local brightness = math.max(0.2, 1 - dist / maxDist)

    -- Draw dark sickly wall color
    love.graphics.setColor(0.3 * brightness, 0.2 * brightness, 0.25 * brightness)
    love.graphics.rectangle("fill", x, screenH/2 - wallHeight/2, screenW/rayCount + 1, wallHeight)

    -- Floor
    love.graphics.setColor(0.1, 0.1, 0.1)
    love.graphics.rectangle("fill", x, screenH/2 + wallHeight/2, screenW/rayCount + 1, screenH/2 - wallHeight/2)

    -- Ceiling
    love.graphics.setColor(0.1, 0.1, 0.15)
    love.graphics.rectangle("fill", x, 0, screenW/rayCount + 1, screenH/2 - wallHeight/2)
  end

  -- UI
  love.graphics.setColor(1, 1, 1)
  love.graphics.print("Up: Move | Left/Right: Turn", 10, screenH - 30)

  -- Check if player is on a screamer tile and trigger image display
  local gridX = math.floor(player.x) + 1
  local gridY = math.floor(player.y) + 1
  
  if dungeon[gridY] and (dungeon[gridY][gridX] == 2 or dungeon[gridY][gridX] == 3 or dungeon[gridY][gridX] == 4) then
    screamerAlpha = 1
  end

  -- Draw screamer image with fade effect
  if screamerAlpha > 0 then
    local image = nil
    if dungeon[gridY] and dungeon[gridY][gridX] == 2 then
      image = image_1
    elseif dungeon[gridY] and dungeon[gridY][gridX] == 3 then
      image = image_2
    elseif dungeon[gridY] and dungeon[gridY][gridX] == 4 then
      image = image_3
    end
    
    if image then
      local scale = screenW / image:getWidth()
      love.graphics.setColor(1, 1, 1, screamerAlpha)
      love.graphics.draw(image, screenW/2, screenH/2, 0, scale, scale, image:getWidth()/2, image:getHeight()/2)
      love.graphics.setColor(1, 1, 1, 1)
    end
  end
end

function castRay(angle)
  local x, y = player.x, player.y
  local dx, dy = math.cos(angle), math.sin(angle)

  for step = 0, maxDist * 100, 0.1 do
    x = player.x + dx * step
    y = player.y + dy * step

    local gridX = math.floor(x)
    local gridY = math.floor(y)

    if gridY < 1 or gridY > #dungeon or gridX < 1 or gridX > #dungeon[1] then
      return step, 0, gridX, gridY
    end

    if dungeon[gridY + 1] and dungeon[gridY + 1][gridX + 1] == 1 then
      return step, 0, gridX + 1, gridY + 1
    end
  end

  return maxDist, 0, 0, 0
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  elseif key == "left" then
    player.angle = player.angle - math.pi / 2
  elseif key == "right" then
    player.angle = player.angle + math.pi / 2
  elseif key == "up" then
    local newX = player.x + math.cos(player.angle)
    local newY = player.y + math.sin(player.angle)
    
    local gridCell = dungeon[math.floor(newY)+1] and dungeon[math.floor(newY)+1][math.floor(newX)+1]
    if gridCell == 0 or gridCell == 2 or gridCell == 3 or gridCell == 4 then
      player.x = newX
      player.y = newY
    end
  end
end
