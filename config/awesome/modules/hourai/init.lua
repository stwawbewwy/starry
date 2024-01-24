local awful = require'awful'
local wibox = require'wibox'
local gears = require'gears'
local bling = require'bling'
local beautiful = require'beautiful'

local mod = require'bindings.mod'
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

local term_scratch = bling.module.scratchpad{
    command = "wezterm start --class spad",
    rule = {instance = "spad"},
    sticky = true,
    autoclose = true,
    floating = true,
    geometry = {x=620, y=52, height = 720, width=1280},
    reapply = true,
    dont_focus_before_close = true,
}

local args = {
    terminal = 'wezterm',
    favorites = {'librewolf', 'wezterm'},
    skip_empty_icons = true,
    placement = awful.placement.right,

    apps_per_row = 5,
    apps_per_column = 2,
    apps_margin = {left = 10, right = 10, top = 10, bottom = 10},
    apps_spacing = 10,

    background = beautiful.bg_normal,
    border_width = 0,
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height)
    end,
    prompt_color = beautiful.bg_focus,
    prompt_icon = '',
    prompt_text = 'Bon voyage! ',
    prompt_text_color = beautiful.fg_focus,
    prompt_cursor_color = beautiful.fg_normal,

    app_shape = function(cr, widget, height)
        gears.shape.rounded_rect(cr, widget, height)
    end,
    app_width = 150,
    app_height = 150,
    app_normal_color = beautiful.bg_normal,
    app_normal_hover_color = beautiful.bg_focus,
    app_selected_color = beautiful.bg_focus,
    app_selected_hover_color = beautiful.bg_focus,
    app_name_normal_color = beautiful.fg_normal,
    app_name_selected_color = beautiful.fg_focus,
    expand_apps = false,
}

local app_launcher = bling.widget.app_launcher(args)

awful.keyboard.append_global_keybindings{
    awful.key{
        modifiers = {mod.super},
        key = 'p',
        description = 'application launcher',
        group = 'launcher',
        on_press = function() app_launcher:toggle() end,
    }
}

eepy:connect_signal('button::press', function(_, _, _, button)
    if button == 3 then
        term_scratch:toggle()
    elseif button == 1 then
        app_launcher:toggle()
    else
    end
end)

return eepy
