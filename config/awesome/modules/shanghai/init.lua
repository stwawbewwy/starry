local awful = require'awful'
local wibox = require'wibox'
local gears = require'gears'
local lain = require'lain'

local apps = require'config.apps'
local home = apps.home

local onecake = home .. 'modules/shanghai/onecake.png'
local twocake = home .. 'modules/shanghai/twocake.png'
local threecake = home .. 'modules/shanghai/threecake.png'
local fourcake = home .. 'modules/shanghai/fourcake.png'
local fivecake = home .. 'modules/shanghai/fivecake.png'

local baticon = wibox.widget{
    widget = wibox.widget.imagebox,
    forced_height = 32,
    forced_width = 160,
    valign = 'center',
}

local batupd = lain.widget.bat{
    timeout = 10,
    settings = function()
        if (not bat_now.status) or bat_now.status == "N/A" or type(bat_now.perc) ~= "number" then return end

        if bat_now.perc >= 100 then
            baticon:set_image(fivecake)
        elseif bat_now.perc >= 80 then
            baticon:set_image(fourcake)
        elseif bat_now.perc >= 60 then
            baticon:set_image(threecake)
        elseif bat_now.perc >= 40 then
            baticon:set_image(twocake)
        elseif bat_now.perc >= 20 then
            baticon:set_image(onecake)
        else
            baticon:set_image()
        end
    end
}

return baticon
