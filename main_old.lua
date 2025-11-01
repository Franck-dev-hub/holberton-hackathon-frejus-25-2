function love.load()
  -- Game parameters
  love.window.setMode(0, 0, {
    fullscreen = true,
    fullscreentype = "desktop",
    vsync = 1,
    resizable = false
  })
  love.window.setTitle("Dungeon Crawler")
  screenW, screenH = love.graphics.getDimensions()

  -- Player
  player = {
    x = 1.5, y = 1.5,
    angle = 0,
    speed = 4,
  }

  -- Dungeon: 1 = wall, 0 = floor, 2/3/4 = screamer
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
  maxDist = 25
  
  -- Screamer state
  elapsedTime = 0
  displayDuration = 2
  showImage = true
  screamerAlpha = 0
  lastScreamerTile = nil

  -- Images
  image_1 = love.graphics.newImage("assets/screamers/screamer_1.png")
  image_2 = love.graphics.newImage("assets/screamers/screamer_2.png")
  image_3 = love.graphics.newImage("assets/screamers/screamer_3.png")

  image_north = love.graphics.newImage("assets/arrows/north.png")
  image_south = love.graphics.newImage("assets/arrows/south.png")
  image_east = love.graphics.newImage("assets/arrows/east.png")
  image_west = love.graphics.newImage("assets/arrows/west.png")
end

function love.update(dt)
  -- Update screamer timing
  elapsedTime = elapsedTime + dt
  if elapsedTime >= displayDuration then
    showImage = false
  end

  -- Check current tile for screamer
  local gridX = math.floor(player.x) + 1
  local gridY = math.floor(player.y) + 1
  local currentTile = dungeon[gridY] and dungeon[gridY][gridX]

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

function love.draw()
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

  -- Draw screamer image
  if showImage then
    local gridX = math.floor(player.x) + 1
    local gridY = math.floor(player.y) + 1
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
    end
  end
end

function castRay(angle)
  local x, y = player.x, player.y
  local dx, dy = math.cos(angle), math.sin(angle)

  for step = 0, maxDist * 100, 0.05 do
    x = player.x + dx * step
    y = player.y + dy * step

    local gridX = math.floor(x)
    local gridY = math.floor(y)

    if gridY < 1 or gridY > #dungeon or gridX < 1 or gridX > #dungeon[1] then
      return step
    end

    if dungeon[gridY + 1] and dungeon[gridY + 1][gridX + 1] == 1 then
      return step
    end
  end

  return maxDist
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
