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
	{ type = "dead", weight = 25000 },

	{ type = "white", weight = 5000 },
	{ type = "red", weight = 1000 },
	{ type = "blue", weight = 1 },
	{ type = "green", weight = 100 },
	{ type = "yellow", weight = 50 },
	{ type = "cyan", weight = 250 },
	{ type = "magenta", weight = 10 },
	{ type = "orange", weight = 69 },
	{ type = "purple", weight = 420 },
	{ type = "pink", weight = 200 },
	{ type = "brown", weight = 500 },
	{ type = "gray", weight = 500 },
	{ type = "lime", weight = 500 },
	{ type = "teal", weight = 500 },
	{ type = "navy", weight = 100 },
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
	local white = countNeighbors(game, x, y, "white")

	if white == 3 then
		return "white"
	end

	return "dead"
end

function Cell:updateWhiteCell(x, y, game, countNeighbors)
	local white = countNeighbors(game, x, y, "white")
	local blue = countNeighbors(game, x, y, "blue")

	if blue > 0 then
		return "blue"
	end

	if white < 2 or white > 3 then
		return "dead"
	end

	return "white"
end

function Cell:updateRedCell(x, y, game, countNeighbors)
	local blue = countNeighbors(game, x, y, "blue")
	local white = countNeighbors(game, x, y, "white")

	if blue == 0 and white ~= 1 then
		return "red"
	end

	if white > 2 then
		return "white"
	end

	return "dead"
end

function Cell:updateBlueCell(x, y, game, countNeighbors)
	local red = countNeighbors(game, x, y, "red")

	if red > 0 then
		return "dead"
	end

	return "blue"
end

function Cell:updateGreenCell(x, y, game, countNeighbors)
	local white = countNeighbors(game, x, y, "white")
	local blue = countNeighbors(game, x, y, "blue")

	if white + blue >= 4 then
		return "lime"
	end

	if white == 0 then
		return "dead"
	end

	return "green"
end

function Cell:updateYellowCell(x, y, game, countNeighbors)
	local red = countNeighbors(game, x, y, "red")

	if red >= 2 then
		return "orange"
	end

	return "yellow"
end

function Cell:updateCyanCell(x, y, game, countNeighbors)
	local navy = countNeighbors(game, x, y, "navy")

	if navy > 0 then
		return "blue"
	end

	return "cyan"
end

function Cell:updateMagentaCell(x, y, game, countNeighbors)
	local white = countNeighbors(game, x, y, "white")
	local pink = countNeighbors(game, x, y, "pink")

	if white >= 2 then
		return "pink"
	end

	if pink == 0 then
		return "dead"
	end

	return "magenta"
end

function Cell:updateOrangeCell(x, y, game, countNeighbors)
	local yellow = countNeighbors(game, x, y, "yellow")

	if yellow < 2 then
		return "dead"
	end

	return "orange"
end

function Cell:updatePurpleCell(x, y, game, countNeighbors)
	local red = countNeighbors(game, x, y, "red")
	local blue = countNeighbors(game, x, y, "blue")

	if red > 0 and blue > 0 then
		return "purple"
	end

	return "dead"
end

function Cell:updatePinkCell(x, y, game, countNeighbors)
	local magenta = countNeighbors(game, x, y, "magenta")

	if magenta >= 1 then
		return "magenta"
	end

	return "pink"
end

function Cell:updateBrownCell(x, y, game, countNeighbors)
	local gray = countNeighbors(game, x, y, "gray")

	if gray > 1 then
		return "dead"
	end

	return "brown"
end

function Cell:updateGrayCell(x, y, game, countNeighbors)
	local white = countNeighbors(game, x, y, "white")
	local black = countNeighbors(game, x, y, "dead") -- Assume dead is black

	if white > black then
		return "white"
	end

	return "gray"
end

function Cell:updateLimeCell(x, y, game, countNeighbors)
	local green = countNeighbors(game, x, y, "green")

	if green >= 2 then
		return "green"
	end

	return "lime"
end

function Cell:updateTealCell(x, y, game, countNeighbors)
	local cyan = countNeighbors(game, x, y, "cyan")
	local blue = countNeighbors(game, x, y, "blue")

	if cyan + blue >= 3 then
		return "cyan"
	end

	return "teal"
end

function Cell:updateNavyCell(x, y, game, countNeighbors)
	local teal = countNeighbors(game, x, y, "teal")

	if teal == 0 then
		return "dead"
	end

	return "navy"
end

-- -- -- -- -- -- -- -- -- --

return Cell
