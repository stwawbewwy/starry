local _M = {}

local awful = require'awful'
local lain = require'lain'
local bling = require'bling'
local l = awful.layout.suit
local j = lain.layout

j.cascade.offset_x = 20
j.cascade.offset_y = 20

_M.layouts = {
    l.spiral.dwindle,
    j.cascade,
}

_M.tags = {
    "    1",
    "    2",
    "    3",
    "    4",
    "    5",
    "    6",
}

_M.defaultlayouts = {
    j.cascade, -- 1
    j.cascade, -- 2
    l.spiral.dwindle, -- 3
    l.spiral.dwindle, -- 4
    l.spiral.dwindle, -- 5
    l.floating, -- 6
}

return _M
