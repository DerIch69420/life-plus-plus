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

function Cell:getRandomType()
    -- Define weights for each type (including dead cells)
    local weightedTypes = {
        { type = "white", weight = 500 },
        { type = "red",   weight = 100 },
        { type = "blue",  weight = 5 },
        { type = nil,     weight = 350 }, -- dead cells
    }

    -- Calculate total weight
    local totalWeight = 0
    for _, entry in ipairs(weightedTypes) do
        totalWeight = totalWeight + entry.weight
    end

    -- Pick a random number in [1, totalWeight]
    local randomWeight = math.random(totalWeight)

    -- Find the type based on the weight intervals
    local cumulative = 0
    for _, entry in ipairs(weightedTypes) do
        cumulative = cumulative + entry.weight
        if randomWeight <= cumulative then
            return entry.type
        end
    end
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

-- -- -- -- -- -- -- -- -- --
-- Update functions
function Cell:updateWhiteCell(x, y, game, countNeighbors)
    local whiteNeighbors = countNeighbors(game, x, y, "white")
    local blueNeighbors = countNeighbors(game, x, y, "blue")

    if blueNeighbors > 0 then
        return "blue"
    end

    if whiteNeighbors < 2 or whiteNeighbors > 3 then
        return nil
    end

    return "white"
end

function Cell:updateRedCell(x, y, game, countNeighbors)
    local totalNeighbors = 0
    for _, t in pairs({ "white", "red", "blue" }) do
        totalNeighbors = totalNeighbors + countNeighbors(game, x, y, t)
    end

    if totalNeighbors == 0 then
        return "red"
    else
        return nil
    end
end

function Cell:updateBlueCell(x, y, game, countNeighbors)
    local redNeighbors = countNeighbors(game, x, y, "red")

    if redNeighbors > 0 then
        return nil
    end

    return "blue"
end

-- -- -- -- -- -- -- -- -- --

return Cell
