local Menu = {}

function Menu:draw()
	-- Background
	love.graphics.clear(0.1, 0.1, 0.2) -- dark blue background

	-- Menu Title
	font = love.graphics.newFont(96)
	love.graphics.setFont(font)
	love.graphics.setColor(1, 1, 1)
	love.graphics.print("Life++", 250, 150)
end

return Menu
