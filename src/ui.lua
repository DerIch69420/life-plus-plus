local UI = {}

UI.__index = UI

function UI:new()
    return setmetatable({ elements = {} }, self)
end

function UI:addElement(element)
    table.insert(self.elements, element)
end

function UI:update()
    for _, e in ipairs(self.elements) do
        if e.update then e:update() end
    end
end

function UI:draw()
    for _, e in ipairs(self.elements) do
        if e.draw then e:draw() end
    end
end

function UI:mousepressed(x, y, button)
    for _, e in ipairs(self.elements) do
        if e.mousepressed then
            e:mousepressed(x, y, button)
        end
    end
end

-- ====== Text ======
UI.Text = {}
UI.Text.__index = UI.Text

function UI.Text:new(content, x, y, size)
    return setmetatable({
        content = content,
        x = x,
        y = y,
        font = love.graphics.newFont(size or 24)
    }, self)
end

function UI.Text:draw()
    love.graphics.setFont(self.font)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(self.content, self.x, self.y)
end

-- ====== Button ======
UI.Button = {}
UI.Button.__index = UI.Button

function UI.Button:new(text, x, y, width, height, callback)
    return setmetatable({
        text = text,
        x = x,
        y = y,
        width = width,
        height = height,
        callback = callback
    }, self)
end

function UI.Button:draw()
    love.graphics.setColor(0.2, 0.6, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 8)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(love.graphics.newFont(20))
    local textWidth = love.graphics.getFont():getWidth(self.text)
    local textHeight = love.graphics.getFont():getHeight()
    love.graphics.print(self.text, self.x + (self.width - textWidth) / 2, self.y + (self.height - textHeight) / 2)
end

function UI.Button:mousepressed(x, y, button)
    if button == 1 and
       x >= self.x and x <= self.x + self.width and
       y >= self.y and y <= self.y + self.height then
        if self.callback then self.callback() end
    end
end

-- ====== ToggleButton ======
UI.ToggleButton = {}
UI.ToggleButton.__index = UI.ToggleButton

function UI.ToggleButton:new(textOn, textOff, x, y, width, height, callback)
    return setmetatable({
        textOn = textOn,
        textOff = textOff,
        x = x,
        y = y,
        width = width,
        height = height,
        callback = callback,
        state = false
    }, self)
end

function UI.ToggleButton:draw()
    local active = self.state
    love.graphics.setColor(active and {0.3, 1, 0.3} or {0.6, 0.6, 0.6})
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 8)

    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(love.graphics.newFont(20))
    local label = active and self.textOn or self.textOff
    local textWidth = love.graphics.getFont():getWidth(label)
    local textHeight = love.graphics.getFont():getHeight()
    love.graphics.print(label, self.x + (self.width - textWidth) / 2, self.y + (self.height - textHeight) / 2)
end

function UI.ToggleButton:mousepressed(x, y, button)
    if button == 1 and
       x >= self.x and x <= self.x + self.width and
       y >= self.y and y <= self.y + self.height then
        self.state = not self.state
        if self.callback then self.callback(self.state) end
    end
end

return {
    UI = UI,
    Text = UI.Text,
    Button = UI.Button,
    ToggleButton = UI.ToggleButton,
}

