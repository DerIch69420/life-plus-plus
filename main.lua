local love = require("love")

local menu = require("src.menu")
local game = require("src.game")

local states = {
	menu = menu,
	game = game,
}
local currentState = menu

function love.load()
	menu:init()

	math.randomseed(os.time())
end

function love.keypressed(key)
	if currentState.keypressed then
		local switchTo = currentState:keypressed(key)
		if switchTo and states[switchTo] then
			currentState = states[switchTo]
			currentState:init()
		end
	end
end

function love.update(dt)
	if currentState.update then
		currentState:update(dt)
	end
end

function love.draw()
	if currentState.draw then
		currentState:draw()
	end
end
