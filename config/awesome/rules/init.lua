local awful = require'awful'
local ruled = require'ruled'
local vars = require'config.vars'

ruled.client.connect_signal('request::rules', function()
   -- All clients will match this rule.
   ruled.client.append_rule{
      id         = 'global',
      rule       = {},
      properties = {
         focus     = awful.client.focus.filter,
         raise     = true,
         screen    = awful.screen.preferred,
         placement = awful.placement.centered + awful.placement.no_offscreen
      }
   }

   -- Floating clients.
   ruled.client.append_rule{
      id = 'floating',
      rule_any = {
         instance = {'copyq', 'pinentry'},
         class = {
            'Arandr',
            'Blueman-manager',
            'Gpick',
            'Kruler',
            'Sxiv',
            'Tor Browser',
            'Wpa_gui',
            'veromix',
            'xtightvncviewer',
            'Thunar',
         },
         -- Note that the name property shown in xprop might be set slightly after creation of the client
         -- and the name shown there might not match defined rules here.
         name = {
            'Event Tester',  -- xev.
         },
         role = {
            'AlarmWindow',    -- Thunderbird's calendar.
            'ConfigManager',  -- Thunderbird's about:config.
            'pop-up',         -- e.g. Google Chrome's (detached) Developer Tools.
         }
      },
      properties = {floating = true}
   }

   ruled.client.append_rule{
       rule_any = {
           class = {'discord'},
       },
       properties = {screen = 1, tag = vars.tags[2]}
   }

   ruled.client.append_rule{
       rule_any = {
           class = {'PrismLauncher', 'steam'}
       },
       properties = {screen = 1, tag =vars.tags[6]}
   }

   -- Add titlebars to normal clients and dialogs
   ruled.client.append_rule{
      id         = 'titlebars',
      rule_any   = {type = {'normal', 'dialog'}},
      properties = {titlebars_enabled = false},
   }
end)

local function spawnonce(app)
    awful.spawn.easy_async_with_shell("ps aux | grep " .. app .. " | grep -v 'grep'", function(stdout)
        if stdout == '' or stdout == nil then
            awful.spawn(app)
        else
            return
        end
    end)
end

spawnonce('discord')
spawnonce('librewolf')
