-- Load spoons
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local hyper = {"⌘", "⌥", "⌃", "⇧"}

hs.hotkey.bind(hyper, "t", function()
  local alacritty = hs.application.find('alacritty')

  if alacritty and alacritty:isFrontmost() then 
    alacritty:hide()
  else
    hs.application.launchOrFocus("/Applications/Alacritty.app")
  end
end)
