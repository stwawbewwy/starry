local awful = require'awful'
local wibox = require'wibox'
local gears = require'gears'
local bling = require'bling'

local apps = require'config.apps'
local home = apps.home

local args = {
    apps_per_column = 1,
    sort_alphabetically = false,
    reverse_sort_alphabetically = true,
}

local text = wibox.widget{
    widget = wibox.widget.textbox,
    halign = true,
    text = 'hi',
}

local app_launcher = bling.widget.app_launcher(args)

text:connect_signal('button::press', function(_, _, _, button)
    if button == 1 then
        app_launcher:toggle()
    else
    end
end)

return text
