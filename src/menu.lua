local Menu = {}
local ui = require("src.ui")

function Menu:init()
    self.font = love.graphics.newFont(96)
    self.ui = ui.UI:new()

    -- Title
    local title = ui.Text:new("Life++", 0, 80, 96)
    function title:draw()
        love.graphics.setFont(self.font)
        love.graphics.setColor(1, 1, 1)
        local textWidth = self.font:getWidth(self.content)
        love.graphics.print(self.content, (990 - textWidth) / 2, self.y)
    end
    title.font = self.font
    self.ui:addElement(title)

    -- Button
    self.startPressed = false
    self.ui:addElement(ui.Button:new("Start", 395, 250, 200, 60, function()
        self.startPressed = true
    end))
end

function Menu:draw()
    love.graphics.clear(0.1, 0.1, 0.2)
    self.ui:draw()
end

function Menu:update(dt)
    self.ui:update()

    if self.startPressed then
        self.startPressed = false -- Reset for possible re-entry
        return "game"
    end
end

function Menu:mousepressed(x, y, button)
    self.ui:mousepressed(x, y, button)
end

function Menu:keypressed(key)
    if key == "return" then
        return "game"
    end
end

return Menu

