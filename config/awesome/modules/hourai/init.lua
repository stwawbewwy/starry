local awful = require'awful'
local wibox = require'wibox'
local gears = require'gears'

local apps = require'config.apps'
local home = apps.home

local sleeping1 = home .. 'modules/hourai/sleeping1.png'
local sleeping2 = home .. 'modules/hourai/sleeping2.png'
local awake1 = home .. 'modules/hourai/awake1.png'
local awake2 = home .. 'modules/hourai/awake2.png'

local eepy = wibox.widget{
    widget = wibox.widget.imagebox,
    forced_height = 32,
    forced_width = 32,
    valign = 'center',
}

local function modecheck()
    local currenttime = tonumber(os.date("%H"))
    if currenttime >= 22 or currenttime <= 5 then
        return true
    else
        return false
    end
end

local timer = gears.timer{
    timeout = 60,
    call_now = true,
    autostart = true,
    callback = function()
        if modecheck() == true then
            if eepy.image ~= sleeping2 then
                eepy:set_image(sleeping2)
                eepy:connect_signal('mouse::enter', function()
                    eepy:set_image(awake1)
                    eepy:connect_signal('mouse::leave', function()
                        eepy:set_image(sleeping2)
                    end)
                end)
            end
        else
            if eepy.image ~= awake1 then
                eepy:set_image(awake1)
            end
        end
        collectgarbage()
    end
}

return eepy
