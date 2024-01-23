local _M = {}

local awful = require'awful'
local lain = require'lain'
local bling = require'bling'
local l = awful.layout.suit
local b = bling.layout

_M.layouts = {
    l.tile,
    l.floating,
    b.equalarea
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
    b.equalarea,
    l.floating,
    l.tile,
    l.floating,
    l.floating,
    l.floating
}

return _M
