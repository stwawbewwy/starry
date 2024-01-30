local _M = {}

local awful = require'awful'
local lain = require'lain'
local bling = require'bling'
local l = awful.layout.suit
local b = bling.layout

_M.layouts = {
    l.spiral,
    l.floating,
    l.max,
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
    l.max, -- 1
    l.max, -- 2
    l.spiral, -- 3
    l.spiral, -- 4
    l.floating, -- 5
    l.floating, -- 6
}

return _M
