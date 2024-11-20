local utils = require 'utils'
require 'windows'

-- Load spoons
hs.loadSpoon 'ReloadConfiguration'
spoon.ReloadConfiguration:start()

-- Change alert style
hs.alert.defaultStyle.textFont = 'Iosevka'
hs.alert.defaultStyle.textSize = 24
hs.alert.defaultStyle.strokeWidth = 0
hs.alert.defaultStyle.radius = 0
hs.alert.defaultStyle.fadeInDuration = 0.10
hs.alert.defaultStyle.fadeOutDuration = 1
hs.alert.defaultStyle.fillColor = { white = 0, alpha = 0.95 }

local osVersion = hs.host.operatingSystemVersionString()

if string.find(osVersion, '10.16') then
  hyperMode = hs.hotkey.modal.new({}, 'F17')
  require 'hyper'
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
  ]] .. 'tell (menu item "' .. deviceName .. '" of menu 1)\n' .. [[
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

local function bindHotkey(appName, key, height)
  hs.hotkey.bind(utils.hyper, key, function()
    local app = hs.application.find(appName)

    if app then
      if app:isFrontmost() then
        app:hide()
      else
        local nowspace = hs.spaces.focusedSpace()
        local screen = hs.screen.mainScreen()
        local app_window = app:mainWindow()
        hs.spaces.moveWindowToSpace(app_window, nowspace)
        local max = screen:fullFrame()
        local f = app_window:frame()
        f.x = max.x
        f.y = max.y
        f.w = max.w
        f.h = max.h * height
        hs.timer.doAfter(0.2, function() app_window:setFrame(f) end)
        app_window:focus()
      end
    else
      hs.application.launchOrFocusByBundleID(appName)
    end
  end)
end

-- App Keybindings --

-- Wezterm
-- Normal
-- hs.hotkey.bind(utils.hyper, 't', function() launchOrHide 'com.github.wez.wezterm' end)
local weztermBundleID = 'com.github.wez.wezterm'
bindHotkey(weztermBundleID, 't', 1) -- full screen
hs.hotkey.bind(utils.hyper, 'b', function() launchOrHide 'company.thebrowser.Browser' end) -- Arc
hs.hotkey.bind(utils.hyper, 'f', function() launchOrHide 'com.DanPristupov.Fork' end) -- Fork

-- Other Keybindings --

-- Toggle AirPods
hs.hotkey.bind(utils.hyper, 'x', function()
  local ok, output = toggleAirpods 'Nano’s AirPods Pro'

  if ok then
    hs.alert.show(output)
  else
    hs.alert.show "Couldn't connect to AirPods"
  end
end)
