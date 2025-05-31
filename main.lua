local love = require("love")

local push = require("push")

local menu = require("src.menu")
local game = require("src.game")

local states = {
	menu = menu,
	game = game,
}
local currentState = menu

local WINDOW_WIDTH, WINDOW_HEIGHT = 990, 510
local VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 990, 510

function love.load()
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = true,
		vsync = true
	})

	menu:init()
	math.randomseed(os.time())
end

function love.resize(w, h)
	push:resize(w, h)
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
	push:start() -- begin drawing with virtual resolution

	if currentState.draw then
		currentState:draw()
	end

	push:finish() -- end drawing with virtual resolution
end

