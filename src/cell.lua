local Cell = {}
Cell.__index = Cell

-- Valid cell types
Cell.types = {
    dead = true, -- black cell

    white = true,
    red = true,
    blue = true,
    green = true,
    yellow = true,
    cyan = true,
    magenta = true,
    orange = true,
    purple = true,
    pink = true,
    brown = true,
    gray = true,
    lime = true,
    teal = true,
    navy = true,
}

-- Colors for each cell type (normalized RGB)
Cell.colors = {
    dead = { 0, 0, 0 },

    white = { 1, 1, 1 },
    red = { 1, 0, 0 },
    blue = { 0, 0, 1 },
    green = { 0, 1, 0 },
    yellow = { 1, 1, 0 },
    cyan = { 0, 1, 1 },
    magenta = { 1, 0, 1 },
    orange = { 1, 0.5, 0 },
    purple = { 0.5, 0, 0.5 },
    pink = { 1, 0.75, 0.8 },
    brown = { 0.6, 0.3, 0 },
    gray = { 0.5, 0.5, 0.5 },
    lime = { 0.75, 1, 0 },
    teal = { 0, 0.5, 0.5 },
    navy = { 0, 0, 0.5 },
}

-- Weighted cell types for random selection
Cell.weightedTypes = {
    { type = "dead",    weight = 2500 },

    { type = "white",   weight = 5000 },
    { type = "red",     weight = 1000 },
    { type = "blue",    weight = 0 },
    { type = "green",   weight = 0 },
    { type = "yellow",  weight = 0 },
    { type = "cyan",    weight = 0 },
    { type = "magenta", weight = 0 },
    { type = "orange",  weight = 0 },
    { type = "purple",  weight = 0 },
    { type = "pink",    weight = 0 },
    { type = "brown",   weight = 0 },
    { type = "gray",    weight = 0 },
    { type = "lime",    weight = 0 },
    { type = "teal",    weight = 0 },
    { type = "navy",    weight = 0 },
}

-- Pick a random cell type based on weights
function Cell:getRandomType()
    local totalWeight = 0
    for _, entry in ipairs(self.weightedTypes) do
        totalWeight = totalWeight + entry.weight
    end

    local r = math.random() * totalWeight
    local cumWeight = 0
    for _, entry in ipairs(self.weightedTypes) do
        cumWeight = cumWeight + entry.weight
        if r <= cumWeight then
            return entry.type
        end
    end
    return "dead" -- fallback to dead instead of nil
end

-- Constructor
function Cell:new(type)
    local obj = setmetatable({}, self)
    type = type or "dead"
    if not Cell.types[type] then
        error("Invalid cell type: " .. tostring(type))
    end
    obj.type = type
    return obj
end

-- Check if the cell is alive (not dead)
function Cell:isAlive()
    return self.type ~= "dead"
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
    type = type or "dead"
    if not Cell.types[type] then
        error("Invalid cell type: " .. tostring(type))
    end
    self.type = type
end

-- Kill the cell (set to dead)
function Cell:kill()
    self.type = "dead"
end

-- -- -- -- -- -- -- -- -- --
-- Update functions
-- General update function that calls the specific update function based on cell type
function Cell:update(x, y, game, countNeighbors)
    local updater = {
        dead = self.updateDeadCell,

        white = self.updateWhiteCell,
        red = self.updateRedCell,
        blue = self.updateBlueCell,
    }

    local updateFunc = updater[self.type]
    if updateFunc then
        return updateFunc(self, x, y, game, countNeighbors)
    else
        return "dead" -- unknown cell type -> dead
    end
end

function Cell:updateDeadCell(x, y, game, countNeighbors)
    local whiteNeighbors = countNeighbors(game, x, y, "white")

    if whiteNeighbors == 3 then
        return "white"
    end

    return "dead"
end

function Cell:updateWhiteCell(x, y, game, countNeighbors)
    local whiteNeighbors = countNeighbors(game, x, y, "white")
    local blueNeighbors = countNeighbors(game, x, y, "blue")

    if blueNeighbors > 0 then
        return "blue"
    end

    if whiteNeighbors < 2 or whiteNeighbors > 3 then
        return "dead"
    end

    return "white"
end

function Cell:updateRedCell(x, y, game, countNeighbors)
    local blueNeighbors = countNeighbors(game, x, y, "blue")

    if blueNeighbors ~= 0 then
        return "red"
    else
        return "white"
    end
end

function Cell:updateBlueCell(x, y, game, countNeighbors)
    local redNeighbors = countNeighbors(game, x, y, "red")

    if redNeighbors > 0 then
        return "dead"
    end

    return "blue"
end

-- -- -- -- -- -- -- -- -- --

return Cell
