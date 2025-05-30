local love = require("love")

function love.conf(t)
    t.identity = "lifeplusplus"         -- Save directory name
    t.appendidentity = false
    t.version = "11.4"
    t.console = false
    t.accelerometerjoystick = false     -- Not needed for this kind of game
    t.externalstorage = false
    t.gammacorrect = false

    t.audio.mic = false
    t.audio.mixwithsystem = false       -- Not using mobile audio

    t.window.title = "life++"
    t.window.icon = nil
    t.window.width = 1920               -- Default resolution for fullscreen
    t.window.height = 1080
    t.window.borderless = false
    t.window.resizable = false
    t.window.minwidth = 1
    t.window.minheight = 1
    t.window.fullscreen = true          -- Enable fullscreen
    t.window.fullscreentype = "desktop"
    t.window.vsync = 1
    t.window.msaa = 0
    t.window.depth = nil
    t.window.stencil = nil
    t.window.display = 1
    t.window.highdpi = true             -- Enable high-DPI for cleaner grid visuals
    t.window.usedpiscale = true
    t.window.x = nil
    t.window.y = nil

    -- Only enable necessary modules
    t.modules.audio = false             -- No sound needed
    t.modules.data = true
    t.modules.event = true
    t.modules.font = true
    t.modules.graphics = true
    t.modules.image = true
    t.modules.joystick = false
    t.modules.keyboard = true
    t.modules.math = true
    t.modules.mouse = true
    t.modules.physics = false           -- Not needed
    t.modules.sound = false             -- Not needed
    t.modules.system = true
    t.modules.thread = false
    t.modules.timer = true
    t.modules.touch = false
    t.modules.video = false
    t.modules.window = true
end

