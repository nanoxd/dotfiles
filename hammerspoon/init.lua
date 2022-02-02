local utils = require('utils')
require('windows')

-- Load spoons
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- Change alert style
hs.alert.defaultStyle.textFont = "Iosevka"
hs.alert.defaultStyle.textSize = 24
hs.alert.defaultStyle.strokeWidth = 0
hs.alert.defaultStyle.radius = 0
hs.alert.defaultStyle.fadeInDuration = 0.10
hs.alert.defaultStyle.fadeOutDuration = 1
hs.alert.defaultStyle.fillColor = { white = 0, alpha = 0.95 }

local osVersion = hs.host.operatingSystemVersionString()

if string.find(osVersion, "10.16") then
  hyperMode = hs.hotkey.modal.new({}, "F17")
  require('hyper')
end

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

local function launchOrHide(bundleID)
  local app = hs.application.find(bundleID)

  if app and app:isFrontmost() then 
    app:hide()
  else
    hs.application.launchOrFocusByBundleID(bundleID)
  end
end

-- App Keybindings --

--[[ -- Alacritty
hs.hotkey.bind(utils.hyper, "t", function()
  -- launchOrHide("io.alacritty")
  launchOrHide("net.kovidgoyal.kitty")
  local app = hs.application.get("kitty")
  app:mainWindow():moveToUnit'[100,100,0,0]'
end)

hs.hotkey.bind(utils.hyper, 'y', function()
  local app = hs.application.get("kitty")

  if app then
      if not app:mainWindow() then
          app:selectMenuItem({"kitty", "New OS window"})
      elseif app:isFrontmost() then
          app:hide()
      else
          app:activate()
      end
  else
      hs.application.launchOrFocus("kitty")
      app = hs.application.get("kitty")
  end

  app:mainWindow():moveToUnit'[100,50,0,0]'
  app:mainWindow().setShadows(false)
end) ]]

-- Other Keybindings --

-- Toggle AirPods
hs.hotkey.bind(utils.hyper, "x", function()
  local ok, output = toggleAirpods('Nano’s AirPods Pro')

  if ok then
    hs.alert.show(output)
  else
    hs.alert.show("Couldn't connect to AirPods")
  end
end)

