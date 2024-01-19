local _M = {}

local awful = require'awful'
local lain = require'lain'
local l = awful.layout.suit
local j = lain.layout

_M.layouts = {
   l.tile,
   l.floating,
   j.centerwork
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
    l.tile,
    l.floating,
    j.centerwork,
    l.floating,
    l.floating,
    l.floating
}

return _M
