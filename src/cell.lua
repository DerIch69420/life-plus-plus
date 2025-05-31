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
    { type = "blue",    weight = 1 },
    { type = "green",   weight = 10 },
    { type = "yellow",  weight = 10 },
    { type = "cyan",    weight = 10 },
    { type = "magenta", weight = 10 },
    { type = "orange",  weight = 10 },
    { type = "purple",  weight = 10 },
    { type = "pink",    weight = 10 },
    { type = "brown",   weight = 10 },
    { type = "gray",    weight = 10 },
    { type = "lime",    weight = 10 },
    { type = "teal",    weight = 10 },
    { type = "navy",    weight = 10 },
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
        green = self.updateGreenCell,
        yellow = self.updateYellowCell,
        cyan = self.updateCyanCell,
        magenta = self.updateMagentaCell,
        orange = self.updateOrangeCell,
        purple = self.updatePurpleCell,
        pink = self.updatePinkCell,
        brown = self.updateBrownCell,
        gray = self.updateGrayCell,
        lime = self.updateLimeCell,
        teal = self.updateTealCell,
        navy = self.updateNavyCell,
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
    local whiteNeighbors = countNeighbors(game, x, y, "white")

    if blueNeighbors == 0 and whiteNeighbors ~= 1 then
        return "red"
    end

    if whiteNeighbors > 2 then
        return "white"
    end

    return "dead"
end

function Cell:updateBlueCell(x, y, game, countNeighbors)
    local redNeighbors = countNeighbors(game, x, y, "red")

    if redNeighbors > 0 then
        return "dead"
    end

    return "blue"
end

function Cell:updateGreenCell(x, y, game, countNeighbors)
    return "green"
end

function Cell:updateYellowCell(x, y, game, countNeighbors)
    return "yellow"
end

function Cell:updateCyanCell(x, y, game, countNeighbors)
    return "cyan"
end

function Cell:updateMagentaCell(x, y, game, countNeighbors)
    return "magenta"
end

function Cell:updateOrangeCell(x, y, game, countNeighbors)
    return "orange"
end

function Cell:updatePurpleCell(x, y, game, countNeighbors)
    return "purple"
end

function Cell:updatePinkCell(x, y, game, countNeighbors)
    return "pink"
end

function Cell:updateBrownCell(x, y, game, countNeighbors)
    return "brown"
end

function Cell:updateGrayCell(x, y, game, countNeighbors)
    return "gray"
end

function Cell:updateLimeCell(x, y, game, countNeighbors)
    return "lime"
end

function Cell:updateTealCell(x, y, game, countNeighbors)
    return "teal"
end

function Cell:updateNavyCell(x, y, game, countNeighbors)
    return "navy"
end

-- -- -- -- -- -- -- -- -- --

return Cell
