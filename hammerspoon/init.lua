hyper = {"⌘", "⌥", "⌃", "⇧"}

  -- A global variable for the Hyper Mode
hyperMode = hs.hotkey.modal.new({}, "F17")

require "hyper"
require "reload_config"

-- Lock System
hyperMode:bind({}, 'Q', 'Lock System', function() hs.caffeinate.lockScreen() end)

