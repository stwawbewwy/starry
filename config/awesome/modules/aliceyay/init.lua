-- title
-- sparkles
-- battery
-- volume
-- brightness
-- music player
-- power menu
-- popup setup

local awful = require'awful'
local wibox = require'wibox'
local gears = require'gears'
local lain = require'lain'
local beautiful = require'beautiful'
local naughty = require'naughty'

local apps = require'config.apps'
local home = apps.home

local bell = home .. 'modules/aliceyay/bell.png'
local bellring = home .. 'modules/aliceyay/bellring.png'

local button = wibox.widget{
    widget = wibox.widget.imagebox,
    forced_height = 32,
    forced_width = 32,
    valign = 'center',
    image = bell,
}

local popup = wibox{
    bg = beautiful.bg_normal,
    fg = beautiful.fg_normal,
    max_widget_size = 500,
    x = 1696,
    y = 52,
    border_width = 2,
    border_color = beautiful.bg_focus,
    width = 200,
    height = 700,
    ontop = true,
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr,width, height, 8)
    end,
}

-- title

local title = wibox.widget{
    widget = wibox.widget.textbox,
    font = 'Pinyon Script 25',
    halign = 'center',
    text = 'Cafe de Starry',
}

-- sparkles

local sparklespng = home .. 'modules/aliceyay/sparkles.png'

local sparkles = wibox.widget{
    widget = wibox.widget.imagebox,
    halign = 'center',
    forced_height = 32,
    forced_width = 32,
    image = sparklespng,
}

-- battery

local battext = wibox.widget{
    widget = wibox.widget.textbox,
    halign = 'center',
}

local batbar = wibox.widget{
    widget = wibox.widget.progressbar,
    max_value = 100,
    forced_height = 30,
    forced_width = 100,
    shape = gears.shape.rounded_bar,
    color = beautiful.fg_focus,
    background_color = beautiful.bg_focus,
}

local cutetext = wibox.widget{
    widget = wibox.widget.textbox,
    halign = 'center',
    text = 'battery',
}

local batupd = lain.widget.bat{
    timeout = 10,
    settings = function()
        if (not bat_now.status) or bat_now.status == "N/A" or type(bat_now.perc) ~= "number" then return end

        battext:set_text(bat_now.perc .. '%')
        batbar:set_value(bat_now.perc)
    end
}

-- volume

local volumetext = wibox.widget{
    widget = wibox.widget.textbox,
    halign = 'center'
}

local cutetext1 = wibox.widget{
    widget = wibox.widget.textbox,
    halign = 'center',
    text = 'volume',
}

local volumebar = wibox.widget{
    widget = wibox.widget.progressbar,
    max_value = 100,
    forced_height = 30,
    forced_width = 100,
    shape = gears.shape.rounded_bar,
    color = beautiful.fg_focus,
    background_color = beautiful.bg_focus,
}

local volume = lain.widget.alsa{
    timeout = 1,
    settings = function()
        volumetext:set_text(volume_now.level .. '%')
        volumebar:set_value(volume_now.level)
    end
}

volumebar:buttons(awful.util.table.join(
    awful.button({}, 1, function() -- left click
        awful.spawn(string.format("%s -e alsamixer", terminal))
    end),
    awful.button({}, 2, function() -- middle click
        os.execute(string.format("%s set %s 100%%", volume.cmd, volume.channel))
        volume.update()
    end),
    awful.button({}, 3, function() -- right click
        os.execute(string.format("%s set %s toggle", volume.cmd, volume.togglechannel or volume.channel))
        volume.update()
    end),
    awful.button({}, 4, function() -- scroll up
        os.execute(string.format("%s set %s 1%%+", volume.cmd, volume.channel))
        volume.update()
    end),
    awful.button({}, 5, function() -- scroll down
        os.execute(string.format("%s set %s 1%%-", volume.cmd, volume.channel))
        volume.update()
    end)
))

awful.keyboard.append_global_keybindings{
    awful.key({}, 'XF86AudioRaiseVolume', function()
        os.execute(string.format('amixer set %s 5%%+', volume.channel))
        volume.update()
    end),
    awful.key({}, 'XF86AudioLowerVolume', function()
        os.execute(string.format('amixer set %s 5%%-', volume.channel))
        volume.update()
    end),
    awful.key({}, 'XF86AudioMute', function()
        os.execute(string.format('amixer set %s toggle', volume.togglechannel or volume.channel))
        volume.update()
    end)
}

-- brightness
local cutetext2 = wibox.widget{
    widget = wibox.widget.textbox,
    halign = 'center',
    text = 'brightness',
}

local brightnesstext = wibox.widget{
    widget = wibox.widget.textbox,
    halign = 'center',
}

local brightnessbar = wibox.widget{
    widget = wibox.widget.progressbar,
    max_value = 255,
    forced_height = 30,
    forced_width = 100,
    shape = gears.shape.rounded_bar,
    color = beautiful.fg_focus,
    background_color = beautiful.bg_focus,
}

local function brightnessupdate()
    awful.spawn.with_line_callback('brightnessctl g', {
        stdout = function(line)
            brightnessbar:set_value(tonumber(line))
            brightnesstext:set_text(math.floor(tonumber(line)/255*100) .. '%')
            naughty.notify({title = 'Brightness', text = brightnesstext.text})
        end
    })
end

local brightness = gears.timer{
    timeout = 60,
    call_now = true,
    autostart = true,
    callback = function()
        awful.spawn.with_line_callback('brightnessctl g', {
            stdout = function(line)
                brightnessbar:set_value(tonumber(line))
                brightnesstext:set_text(math.floor(tonumber(line)/255*100) .. '%')
            end
        })
    end
}

awful.keyboard.append_global_keybindings{
    awful.key({}, 'XF86MonBrightnessDown', function()
        brightnessupdate()
    end),
    awful.key({}, 'XF86MonBrightnessUp', function()
        brightnessupdate()
    end)
}

-- music player
local playing = home .. 'modules/aliceyay/playing.png'
local notplaying = home .. 'modules/aliceyay/not_playing.png'

local musicplayer = wibox.widget{
    widget = wibox.widget.imagebox,
    forced_height = 64,
    forced_width = 64,
    valign = 'center',
    halign = 'center',
}

local musictext = wibox.widget{
    widget = wibox.widget.textbox,
    halign = 'center',
}

local musictitle = wibox.widget{
    widget = wibox.widget.textbox,
    halign = 'center',
}

local function statuscheck()
    awful.spawn.with_line_callback('playerctl --player=cmus status', {
        stdout = function(line)
            if line == 'Stopped' or line == 'Paused' then
                musicplayer:set_image(notplaying)
                musictext:set_text(line)
            else
                musicplayer:set_image(playing)
                musictext:set_text(line)
            end
        end,
        stderr = function()
            musicplayer:set_image(notplaying)
            musictext:set_text('No music')
        end
    })
end

local function nowplaying()
    awful.spawn.with_line_callback('playerctl --player=cmus metadata title', {
        stdout = function(line)
            musictitle:set_text(line)
        end,
        stderr = function()
            musictitle:set_text('):')
        end
    })
end

local musictimer = gears.timer{
    timeout = 30,
    call_now = true,
    autostart = true,
    callback = function()
        statuscheck()
        nowplaying()
        collectgarbage()
    end
}

musicplayer:connect_signal('button::press', function(_, _, _, button)
    if button == 1 then
        awful.spawn.with_shell('playerctl --player=cmus play-pause')
        statuscheck()
        collectgarbage()
    end
end)

-- power menu

local powerbuttonsvg = home .. 'modules/aliceyay/power.svg'

local powerbutton = wibox.widget{
    widget = wibox.widget.imagebox,
    forced_height = 50,
    forced_width = 50,
    valign = 'center',
    halign = 'center',
    image = gears.color.recolor_image(powerbuttonsvg, beautiful.bg_focus)
}

local logoutbuttonsvg = home .. 'modules/aliceyay/log-out.svg'

local logoutbutton = wibox.widget{
    widget = wibox.widget.imagebox,
    forced_height = 50,
    forced_width = 50,
    valign = 'center',
    halign = 'center',
    image = gears.color.recolor_image(logoutbuttonsvg, beautiful.bg_focus)
}

local rebootbuttonsvg = home .. 'modules/aliceyay/rotate-ccw.svg'

local rebootbutton = wibox.widget{
    widget = wibox.widget.imagebox,
    forced_height = 50,
    forced_width = 50,
    valign = 'center',
    halign = 'center',
    image = gears.color.recolor_image(rebootbuttonsvg, beautiful.bg_focus)
}

local function powermenu(option, action)
    option:connect_signal('button::press', function(_, _, _, button)
        if button == 1 then
            os.execute(action)
        else
        end
    end)
end

local function changecolor(option, image)
    option:connect_signal('mouse::enter', function()
        option:set_image(gears.color.recolor_image(image, beautiful.fg_focus))
        option:connect_signal('mouse::leave', function()
            option:set_image(gears.color.recolor_image(image, beautiful.bg_focus))
        end)
    end)
end

changecolor(powerbutton, powerbuttonsvg)
changecolor(logoutbutton, logoutbuttonsvg)
changecolor(rebootbutton, rebootbuttonsvg)

powermenu(powerbutton, 'systemctl poweroff')
powermenu(rebootbutton, 'systemctl reboot')

logoutbutton:connect_signal('button::press', function(_, _, _, button)
    if button == 1 then
        awesome.quit()
    end
end)

-- popup setup

popup:setup{
    {
        wibox.container.margin(title, 0, 0, 30, 0),
        {
            {
                sparkles,
                cutetext,
                battext,
                spacing = 10,
                layout = wibox.layout.fixed.horizontal,
            },
            batbar,
            spacing = 10,
            layout = wibox.layout.fixed.vertical,
        },
        {
            {
                sparkles,
                cutetext1,
                volumetext,
                spacing = 10,
                layout = wibox.layout.fixed.horizontal,
            },
            volumebar,
            spacing = 10,
            layout = wibox.layout.fixed.vertical,
        },
        {
            {
                sparkles,
                cutetext2,
                brightnesstext,
                spacing = 10,
                layout = wibox.layout.fixed.horizontal,
            },
            brightnessbar,
            spacing = 10,
            layout = wibox.layout.fixed.vertical,
        },
        {
            musicplayer,
            musictext,
            musictitle,
            spacing = 10,
            layout = wibox.layout.align.vertical,
        },
        {
            powerbutton,
            logoutbutton,
            rebootbutton,
            spacing = 10,
            layout = wibox.layout.align.horizontal,
        },
        spacing = 50,
        layout = wibox.layout.fixed.vertical,
    },
    id = 'a',
    valign = 'top',
    layout = wibox.container.place
}

local function toggle(shade)
    if shade.visible == false then
        shade.visible = true
    else
        shade.visible = false
    end
end

button:connect_signal('mouse::enter', function()
    button:set_image(bellring)
    button:connect_signal('mouse::leave', function()
        button:set_image(bell)
    end)
end)

button:connect_signal('button::press', function(_, _, _, button)
    if button == 1 then
        toggle(popup)
    end
end)

return button
