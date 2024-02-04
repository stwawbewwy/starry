local awful = require'awful'
local wibox = require'wibox'
local gears = require'gears'
local beautiful = require'beautiful'

local mod = require'bindings.mod'
local apps = require'config.apps'
local home = apps.home

local sleeping1 = home .. 'modules/hourai/awake1.png'
local sleeping2 = home .. 'modules/hourai/awake2.png'

local anim = {sleeping1, sleeping2}

local eepy = wibox.widget{
    widget = wibox.widget.imagebox,
    forced_height = 32,
    forced_width = 32,
    valign = 'center',
}

local current_frame = 1

local function timer()
    return gears.timer{
        timeout = 1,
        call_now = true,
        autostart = true,
        callback = function()
            if current_frame <= 1 then
                eepy:set_image(anim[current_frame])
                current_frame = current_frame + 1
            else
                current_frame = 1
                eepy:set_image(anim[2])
            end
        end
    }
end

return eepy
