local Game = {}

local screenWidth, screenHeight = love.graphics.getDimensions()

Game.cellSize = 10
Game.gridWidth = math.floor(screenWidth / Game.cellSize)
Game.gridHeight = math.floor(screenHeight / Game.cellSize)

Game.grid = {}
Game.nextGrid = {}

function Game:initGrid()
    for x = 0, self.gridWidth - 1 do
        self.grid[x] = {}
        self.nextGrid[x] = {}
        for y = 0, self.gridHeight - 1 do
            self.grid[x][y] = math.random(0, 1)
            self.nextGrid[x][y] = 0
        end
    end
end

function Game:countNeighbors(x, y)
    local count = 0
    for dx = -1, 1 do
        for dy = -1, 1 do
            if not (dx == 0 and dy == 0) then
                local nx, ny = x + dx, y + dy
                if nx >= 0 and nx < self.gridWidth and ny >= 0 and ny < self.gridHeight then
                    count = count + self.grid[nx][ny]
                end
            end
        end
    end
    return count
end

function Game:updateGrid()
    for x = 0, self.gridWidth - 1 do
        for y = 0, self.gridHeight - 1 do
            local neighbors = self:countNeighbors(x, y)
            local alive = self.grid[x][y]

            if alive == 1 and (neighbors < 2 or neighbors > 3) then
                self.nextGrid[x][y] = 0
            elseif alive == 0 and neighbors == 3 then
                self.nextGrid[x][y] = 1
            else
                self.nextGrid[x][y] = alive
            end
        end
    end
    self.grid, self.nextGrid = self.nextGrid, self.grid
end

function Game:draw()
    love.graphics.setColor(1, 1, 1)
    for x = 0, self.gridWidth - 1 do
        for y = 0, self.gridHeight - 1 do
            if self.grid[x][y] == 1 then
                love.graphics.rectangle("fill", x * self.cellSize, y * self.cellSize, self.cellSize, self.cellSize)
            end
        end
    end
end

return Game
