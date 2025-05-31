local UI = {}
UI.__index = UI

-- Button class
local Button = {}
Button.__index = Button

function Button:new(text, x, y, width, height, onClick)
    return setmetatable({
        text = text,
        x = x,
        y = y,
        width = width,
        height = height,
        onClick = onClick,
        font = love.graphics.newFont(24),
        hover = false
    }, Button)
end

function Button:draw()
    love.graphics.setFont(self.font)
    if self.hover then
        love.graphics.setColor(0.6, 0.6, 1)
    else
        love.graphics.setColor(0.3, 0.3, 0.8)
    end
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 10, 10)

    love.graphics.setColor(1, 1, 1)
    local textWidth = self.font:getWidth(self.text)
    local textHeight = self.font:getHeight(self.text)
    love.graphics.print(self.text, self.x + (self.width - textWidth) / 2, self.y + (self.height - textHeight) / 2)
end

function Button:update(mx, my)
    self.hover = mx >= self.x and mx <= self.x + self.width and my >= self.y and my <= self.y + self.height
end

function Button:mousepressed(mx, my, button)
    if button == 1 and self.hover then
        if self.onClick then
            self.onClick()
        end
    end
end

-- Text module
local Text = {}
Text.__index = Text

function Text:new(content, x, y, fontSize)
    return setmetatable({
        content = content,
        x = x,
        y = y,
        font = love.graphics.newFont(fontSize or 20)
    }, Text)
end

function Text:draw()
    love.graphics.setFont(self.font)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(self.content, self.x, self.y)
end

-- UI methods
function UI:new()
    return setmetatable({
        elements = {}
    }, UI)
end

function UI:addElement(element)
    table.insert(self.elements, element)
end

function UI:draw()
    for _, element in ipairs(self.elements) do
        element:draw()
    end
end

function UI:update()
    local mx, my = love.mouse.getPosition()
    for _, element in ipairs(self.elements) do
        if element.update then
            element:update(mx, my)
        end
    end
end

function UI:mousepressed(x, y, button)
    for _, element in ipairs(self.elements) do
        if element.mousepressed then
            element:mousepressed(x, y, button)
        end
    end
end

-- Export the UI class
return {
    UI = UI,
    Button = Button,
    Text = Text
}

