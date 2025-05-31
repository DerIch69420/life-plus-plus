local Menu = {}

function Menu:init()
    self.font = love.graphics.newFont(96)
end

function Menu:draw()
    love.graphics.clear(0.1, 0.1, 0.2) -- dark blue background

    love.graphics.setFont(self.font)
    love.graphics.setColor(1, 1, 1)

    -- Center text horizontally and place vertically in the upper half
    local text = "Life++"
    local textWidth = self.font:getWidth(text)
    local x = (990 - textWidth) / 2
    local y = 80 -- somewhere near top middle

    love.graphics.print(text, x, y)
end

function Menu:update(dt)
end

function Menu:keypressed(key)
    if key == "return" then
        return "game"
    end
end

return Menu

