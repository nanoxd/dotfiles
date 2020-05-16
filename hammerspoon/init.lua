-- Load spoons
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local hyper = {"⌘", "⌥", "⌃", "⇧"}

-- Functions

local function toggleAirpods(deviceName)
  local s = [[
    activate application "SystemUIServer"
    tell application "System Events"
      tell process "SystemUIServer"
        set btMenu to (menu bar item 1 of menu bar 1 whose description contains "bluetooth")
        tell btMenu
          click
  ]]
  ..
          'tell (menu item "' .. deviceName .. '" of menu 1)\n'
  ..
  [[
            click
            if exists menu item "Connect" of menu 1 then
              click menu item "Connect" of menu 1
              return "Connecting AirPods..."
            else
              click menu item "Disconnect" of menu 1
              return "Disconecting AirPods..."
            end if
          end tell
        end tell
      end tell
    end tell
  ]]

  return hs.osascript.applescript(s)
end

-- App Keybindings --

-- Alacritty
hs.hotkey.bind(hyper, "t", function()
  local alacritty = hs.application.find('alacritty')

  if alacritty and alacritty:isFrontmost() then 
    alacritty:hide()
  else
    hs.application.launchOrFocus("/Applications/Alacritty.app")
  end
end)

-- Other Keybindings --

-- Toggle AirPods
hs.hotkey.bind(hyper, "x", function()
  local ok, output = toggleAirpods('Nano’s AirPods Pro')

  if ok then
    hs.alert.show(output)
  else
    hs.alert.show("Couldn't connect to AirPods")
  end
end)
