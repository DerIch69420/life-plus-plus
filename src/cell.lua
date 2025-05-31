local Cell = {}
Cell.__index = Cell

-- Valid cell types
Cell.types = {
    white = true,
    red = true,
    blue = true,
}

-- Colors for each cell type
Cell.colors = {
    white = { 1, 1, 1 },
    red = { 1, 0, 0 },
    blue = { 0, 0, 1 },
}

-- Constructor
function Cell:new(type)
    local obj = setmetatable({}, self)
    if type and not Cell.types[type] then
        error("Invalid cell type: " .. tostring(type))
    end
    obj.type = type or nil
    return obj
end

-- Check if the cell is alive (has a type)
function Cell:isAlive()
    return self.type ~= nil
end

-- Get the cell's color; default to black if dead or unknown
function Cell:getColor()
    if self.type and Cell.colors[self.type] then
        return unpack(Cell.colors[self.type])
    else
        return 0, 0, 0
    end
end

-- Change the cell's type
function Cell:setType(type)
    if type and not Cell.types[type] then
        error("Invalid cell type: " .. tostring(type))
    end
    self.type = type
end

-- Kill the cell
function Cell:kill()
    self.type = nil
end

return Cell
