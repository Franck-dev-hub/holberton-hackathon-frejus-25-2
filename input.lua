-- Manage keyboard
function input_keypressed(key)
  if key == "escape" then
    love.event.quit()
  elseif key == "left" or key == "a" then
    player_rotate(-math.pi / 2)
  elseif key == "right" or key == "d" then
    player_rotate(math.pi / 2)
  elseif key == "up" or key == "w" then
    player_move(1)
  end
end
