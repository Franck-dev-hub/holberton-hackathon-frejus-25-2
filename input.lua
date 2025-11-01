function input_keypressed(key)
  if key == "escape" then
    love.event.quit()
  elseif key == "left" then
    player_rotate(-math.pi / 2)
  elseif key == "right" then
    player_rotate(math.pi / 2)
  elseif key == "up" then
    player_move(1)
  end
end
