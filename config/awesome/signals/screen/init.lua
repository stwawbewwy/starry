local awful = require'awful'
local beautiful = require'beautiful'
local wibox = require'wibox'
local gears = require'gears'

local vars = require'config.vars'
local widgets = require'widgets'
local modules = require'modules'

screen.connect_signal('request::wallpaper', function(s)
    awful.wallpaper{
        screens = {
            screen[1],
        },
        widget = {
            {
                image     = beautiful.wallpaper,
                resize    = true,
                widget    = wibox.widget.imagebox,
            },
            valign = 'center',
            halign = 'center',
            tiled = false,
            widget = wibox.container.tile,
        }

    }
end)

screen.connect_signal('request::desktop_decoration', function(s)
    awful.tag(vars.tags, s, vars.defaultlayouts)
    s.promptbox = widgets.create_promptbox()
    s.layoutbox = widgets.create_layoutbox(s)
    s.taglist   = widgets.create_taglist(s)
    s.tasklist  = widgets.create_tasklist(s)
    s.wibox     = widgets.create_wibox(s)
    s.popup     = modules.aliceyay.popup
end)
