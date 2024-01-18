local awful = require'awful'
local wibox = require'wibox'
local gears = require'gears'

local apps = require'config.apps'
local home = apps.home

local sleeping = home .. 'modules/hourai/sleeping.png'
local awake = home .. 'modules/hourai/awake.png'

local eepy = wibox.widget{
    widget = wibox.widget.imagebox,
    forced_height = 32,
    forced_width = 32,
    valign = 'center',
}

gears.timer{
    timeout = 60,
    call_now = true,
    autostart = true,
    callback = function()
        local currenttime = tonumber(os.date("%H"))
        if currenttime >= 22 or currenttime <= 5 then
            if eepy.image ~= sleeping then
                eepy:set_image(sleeping)
                eepy:connect_signal('mouse::enter', function()
                    eepy:set_image(awake)
                    eepy:connect_signal('mouse::leave', function()
                        eepy:set_image(sleeping)
                    end)
                end)
            else
            end
        else
            if eepy.image ~= awake then
                eepy:set_image(awake)
            else
            end
        end
        collectgarbage()
    end
}

return eepy
