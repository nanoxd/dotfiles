hyper = {"⌘", "⌥", "⌃", "⇧"}

  -- A global variable for the Hyper Mode
hyperMode = hs.hotkey.modal.new({}, "F17")

require 'util'
require "hyper"
require "reload_config"
require "mobility"

-- Lock System
hyperMode:bind({}, 'Q', 'Lock System', function() hs.caffeinate.lockScreen() end)
