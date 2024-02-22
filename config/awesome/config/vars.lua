local _M = {}

local awful = require'awful'
local lain = require'lain'
local l = awful.layout.suit

_M.layouts = {
    l.tile.right,
    l.tile.bottom,
    l.fair,
    l.max,
    l.floating,
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
    _M.layouts[4], -- 1
    _M.layouts[4], -- 2
    _M.layouts[1], -- 3
    _M.layouts[2], -- 4
    _M.layouts[3], -- 5
    _M.layouts[5], -- 6
}

return _M
