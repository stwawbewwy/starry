local _M = {}

local awful = require'awful'
local l = awful.layout.suit

_M.layouts = {
   awful.layout.suit.tile,
   awful.layout.suit.floating,
   awful.layout.suit.max,
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
    l.tile,
    l.floating,
    l.floating,
    l.floating
}

return _M
