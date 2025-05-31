function love.conf(t)
    t.identity = "lifeplusplus"
    t.appendidentity = false
    t.version = "11.4"
    t.console = false
    t.accelerometerjoystick = false
    t.externalstorage = false
    t.gammacorrect = false

    t.audio.mic = false
    t.audio.mixwithsystem = false

    t.window.title = "life++"
    t.window.icon = nil
    t.window.width = 1280           -- Real window size (can be fullscreen res)
    t.window.height = 720
    t.window.borderless = false
    t.window.resizable = true       -- Make window resizable so push can handle resize
    t.window.minwidth = 640         -- Minimal size limits, optional
    t.window.minheight = 360
    t.window.fullscreen = false     -- Start windowed; fullscreen can interfere with resizing
    t.window.fullscreentype = "desktop"
    t.window.vsync = 1
    t.window.msaa = 0
    t.window.depth = nil
    t.window.stencil = nil
    t.window.display = 1
    t.window.highdpi = true
    t.window.usedpiscale = true
    t.window.x = nil
    t.window.y = nil

    -- Modules
    t.modules.audio = false
    t.modules.data = true
    t.modules.event = true
    t.modules.font = true
    t.modules.graphics = true
    t.modules.image = true
    t.modules.joystick = false
    t.modules.keyboard = true
    t.modules.math = true
    t.modules.mouse = true
    t.modules.physics = false
    t.modules.sound = false
    t.modules.system = true
    t.modules.thread = false
    t.modules.timer = true
    t.modules.touch = false
    t.modules.video = false
    t.modules.window = true
end

