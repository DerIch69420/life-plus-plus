local love = require("love")

local game = require("src.game")

function love.load()
    math.randomseed(os.time())
    game:initGrid()
end

function love.draw()
    game:draw()
end

function love.update(dt)
    game:updateGrid()
end
