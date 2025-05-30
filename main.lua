local love = require("love")

local state = require("src.state")
local menu = require("src.menu")
local game = require("src.game")

function love.load()
	state:init()

	math.randomseed(os.time())
	game:initGrid()
end

function love.keypressed(key)
	if state:is("menu") then
		if key == "return" then
			state:update("game")
		end
	elseif state:is("game") then
		if key == "escape" then
			state:update("menu")
		end
	end
end

function love.draw()
	if state:is("menu") then
		menu:draw()
	elseif state.is("game") then
		game:draw()
	end
end

function love.update(dt)
	if state:is("menu") then
	elseif state.is("game") then
		game:updateGrid()
	end
end
