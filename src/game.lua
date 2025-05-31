local cell = require("src.cell")

local Game = {}

local screenWidth, screenHeight = love.graphics.getDimensions()

Game.cellSize = 5
Game.gridWidth = math.floor(screenWidth / Game.cellSize)
Game.gridHeight = math.floor(screenHeight / Game.cellSize)

Game.grid = {}
Game.nextGrid = {}

function Game:init()
    for x = 0, self.gridWidth - 1 do
        self.grid[x] = {}
        self.nextGrid[x] = {}
        for y = 0, self.gridHeight - 1 do
            local randomType = cell:getRandomType()
            self.grid[x][y] = cell:new(randomType)
            self.nextGrid[x][y] = cell:new(nil)
        end
    end
end

-- Counts neighbors of a specific type around (x, y)
function Game:countNeighbors(x, y, cellType)
    local count = 0
    for dx = -1, 1 do
        for dy = -1, 1 do
            if not (dx == 0 and dy == 0) then
                local nx, ny = x + dx, y + dy
                if nx >= 0 and nx < self.gridWidth and ny >= 0 and ny < self.gridHeight then
                    if self.grid[nx][ny].type == cellType then
                        count = count + 1
                    end
                end
            end
        end
    end
    return count
end

function Game:update(dt)
    for x = 0, self.gridWidth - 1 do
        for y = 0, self.gridHeight - 1 do
            local currentCell = self.grid[x][y]
            local newType = nil

            -- Use Cell:update to determine the new type based on current type
            newType = currentCell:update(x, y, self, self.countNeighbors)

            self.nextGrid[x][y]:setType(newType)
        end
    end
    self.grid, self.nextGrid = self.nextGrid, self.grid
end

function Game:draw()
    for x = 0, self.gridWidth - 1 do
        for y = 0, self.gridHeight - 1 do
            local c = self.grid[x][y]
            if c:isAlive() then
                love.graphics.setColor(c:getColor())
                love.graphics.rectangle("fill", x * self.cellSize, y * self.cellSize, self.cellSize, self.cellSize)
            end
        end
    end
    love.graphics.setColor(0, 0, 0) -- reset color to black
end

function Game:keypressed(key)
    if key == "escape" then
        return "menu"
    end
end

return Game
