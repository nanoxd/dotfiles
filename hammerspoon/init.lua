hyper = {"⌘", "⌥", "⌃", "⇧"}

  -- A global variable for the Hyper Mode
hyperMode = hs.hotkey.modal.new({}, "F17")

require 'util'
require "hyper"
require "reload_config"
require 'window_management'
require 'vim'
-- require "mobility"

-- Lock System
hyperMode:bind({}, 'Q', 'Lock System', function() hs.caffeinate.lockScreen() end)

-- Setup SpoonInstall for bundling magic
hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall.repos.zzspoons = {
   url = "https://github.com/zzamboni/zzSpoons",
   desc = "zzamboni's spoon repository",
}

spoon.SpoonInstall.use_syncinstall = true

spoon.SpoonInstall:andUse("WiFiTransitions",
  {
    repo = 'zzspoons',
    config = {
        actions = {
          { -- Test action just to see the SSID transitions
             fn = function(_, _, prev_ssid, new_ssid)
                hs.notify.show("SSID change", string.format("From '%s' to '%s'", prev_ssid, new_ssid), "")
             end
          },
          -- { -- Enable proxy in Spotify and Adium config when joining corp network
          --     to = "corpnet01",
          --     fn = {hs.fnutils.partial(reconfigSpotifyProxy, true),
          --           hs.fnutils.partial(reconfigAdiumProxy, true),
          --     }
          -- },
          -- { -- Disable proxy in Spotify and Adium config when leaving corp network
          --     from = "corpnet01",
          --     fn = {hs.fnutils.partial(reconfigSpotifyProxy, false),
          --           hs.fnutils.partial(reconfigAdiumProxy, false),
          --     }
          -- },
        }
    },
    start = true,
    }
)
