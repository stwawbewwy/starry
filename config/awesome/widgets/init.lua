local _M = {}

local awful = require'awful'
local hotkeys_popup = require'awful.hotkeys_popup'
local beautiful = require'beautiful'
local wibox = require'wibox'
local gears = require'gears'
local lain = require'lain'
local modules = require'modules'

local apps = require'config.apps'
local mod = require'bindings.mod'

local textclock = wibox.widget.textclock('%R %a %d/%m/%Y', 1)

local mycal = lain.widget.cal{
    attach_to = {textclock},
    notification_preset = {
        font = "Comic Mono 10",
        fg = beautiful.fg_focus,
        bg = beautiful.bg_focus,
    }
}

function _M.create_promptbox() return awful.widget.prompt() end

function _M.create_layoutbox(s)
    return awful.widget.layoutbox{
        screen = s,
        buttons = {
            awful.button{
                modifiers = {},
                button    = 1,
                on_press  = function() awful.layout.inc(1) end,
            },
            awful.button{
                modifiers = {},
                button    = 3,
                on_press  = function() awful.layout.inc(-1) end,
            },
            awful.button{
                modifiers = {},
                button    = 4,
                on_press  = function() awful.layout.inc(-1) end,
            },
            awful.button{
                modifiers = {},
                button    = 5,
                on_press  = function() awful.layout.inc(1) end,
            },
        }
    }
end

function _M.create_taglist(s)
    return awful.widget.taglist{
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {
            shape = gears.shape.rounded_bar,
            valign = 'center',
        },
        buttons = {
            awful.button{
                modifiers = {},
                button    = 1,
                on_press  = function(t) t:view_only() end,
            },
            awful.button{
                modifiers = {mod.super},
                button    = 1,
                on_press  = function(t)
                    if client.focus then
                        client.focus:move_to_tag(t)
                    end
                end,
            },
            awful.button{
                modifiers = {},
                button    = 3,
                on_press  = awful.tag.viewtoggle,
            },
            awful.button{
                modifiers = {mod.super},
                button    = 3,
                on_press  = function(t)
                    if client.focus then
                        client.focus:toggle_tag(t)
                    end
                end
            },
        },
    }
end

function _M.create_tasklist(s)
    return awful.widget.tasklist{
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        style = {
            shape = gears.shape.rounded_bar,
        },
        --[[
        style = {
            shape = gears.shape.rounded_bar,
        },
        --]]
        layout = {
            spacing = 10,
            forced_width = 640,
            spacing_widget = {
                {
                    forced_width = 5,
                    shape = gears.shape.circle,
                    widget = wibox.widget.separator
                },
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            layout = wibox.layout.flex.horizontal
        },
        buttons = {
            awful.button{
                modifiers = {},
                button    = 1,
                on_press  = function(c)
                    c:activate{context = 'tasklist', action = 'toggle_minimization'}
                end,
            },
        },
        widget_template = {
            {
                {
                    {
                        {
                            id = 'icon_role',
                            widget = wibox.widget.imagebox,
                        },
                        margins = 2,
                        widget  = wibox.container.margin,
                    },
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 10,
                right = 10,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
        },
    }
end

function _M.create_wibox(s)
    return awful.wibar{
        screen = s,
        position = 'top',
        height = 32,
        widget = {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            -- left widgets
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = 10,
                wibox.container.margin(s.layoutbox, 10, 0),
                s.taglist,
                -- modules.test,
            },
            -- middle widgets
            {
                layout = wibox.layout.fixed.horizontal,
                s.tasklist,
            },
            -- right widgets
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = 10,
                textclock,
                modules.hourai,
                modules.shanghai,
                wibox.container.margin(modules.aliceyay.button, 0, 10),
            }
        }
    }
end

return _M
