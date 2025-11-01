function player_init()
  player = {
    x = 1.5, y = 1.5,
    angle = 0,
    speed = 4,
  }
end

function player_move(direction)
  local newX = player.x + math.cos(player.angle) * direction
  local newY = player.y + math.sin(player.angle) * direction
  
  local gridCell = dungeon[math.floor(newY)+1] and dungeon[math.floor(newY)+1][math.floor(newX)+1]
  if gridCell == 0 or gridCell == 2 or gridCell == 3 or gridCell == 4 then
    player.x = newX
    player.y = newY
  end
end

function player_rotate(angle)
  player.angle = player.angle + angle
end
