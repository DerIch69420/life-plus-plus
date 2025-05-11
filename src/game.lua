local Game = {}

function Game.initGrid(gridWith, gridHeight)
	local grid = {}

	for x = 0, gridWith - 1 do
		grid[x] = {}

		for y = 0, gridHeight - 1 do
			grid[x][y] = math.random(0, 1)
		end
	end

	return grid
end

function Game.neighbors() end

function Game.updateGrid() end

function Game.showGrid() end

return Game
