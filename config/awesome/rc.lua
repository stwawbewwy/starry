-- awesome_mode: api-level=4:screen=on

-- load luarocks if installed
pcall(require, 'luarocks.loader')

-- load theme
local beautiful = require'beautiful'
local gears = require'gears'
beautiful.init(gears.filesystem.get_configuration_dir() .. '/theme.lua')

-- load key and mouse bindings
require'bindings'

-- load rules
require'rules'

-- load signals
require'signals'

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
gears.timer{
    timeout = 5,
    autostart = true,
    call_now = true,
    callback = function()
        collectgarbage("collect")
    end,
}
