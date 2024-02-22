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

local function checkimage(image)
    if baticon.image ~= image then
        baticon:set_image(image)
    end
end

local batupd = lain.widget.bat{
    timeout = 10,
    notify = 'off',
    settings = function()
        if (not bat_now.status) or bat_now.status == "N/A" or type(bat_now.perc) ~= "number" then return end

        if bat_now.perc >= 100 then
            checkimage(fivecake)
        elseif bat_now.perc >= 80 then
            checkimage(fourcake)
        elseif bat_now.perc >= 60 then
            checkimage(threecake)
        elseif bat_now.perc >= 40 then
            checkimage(twocake)
        elseif bat_now.perc >= 20 then
            checkimage(onecake)
        else
            baticon:set_image()
        end
    end
}

return baticon
