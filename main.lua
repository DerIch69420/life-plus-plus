local love = require("love")

local game = require("src.game")

local screenWidth, screenheight = love.graphics.getDimensions()
local cellSize = 2
local gridWith, gridHeight = screenWidth / cellSize, screenheight / cellSize
local grid, nextGrid = {}, {}

function love.load()
    math.randomseed(os.time())
	grid = game.initGrid(gridWith, gridHeight)
end

function love.draw() end

function love.update(dt) end
