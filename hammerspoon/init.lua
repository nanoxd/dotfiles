local utils = require 'utils'
require 'hs.ipc'
require 'windows'

-- Change alert style
hs.alert.defaultStyle.textFont = utils.resolveFont(utils.monospaceFonts)
hs.alert.defaultStyle.textSize = 24
hs.alert.defaultStyle.strokeWidth = 0
hs.alert.defaultStyle.radius = 0
hs.alert.defaultStyle.fadeInDuration = 0.10
hs.alert.defaultStyle.fadeOutDuration = 1
hs.alert.defaultStyle.fillColor = { white = 0, alpha = 0.95 }

-- Load spoons
hs.loadSpoon 'ReloadConfiguration'
spoon.ReloadConfiguration:start()

-- Functions

local function launchOrHide(bundleID)
  local app = hs.application.find(bundleID)

  if app and app:isFrontmost() then
    app:hide()
    return
  end

  if not hs.application.launchOrFocusByBundleID(bundleID) then
    utils.notify('Unable to launch ' .. bundleID)
  end
end

local function moveWindowToCurrentSpace(win, height)
  local ok, nowspace = pcall(hs.spaces.focusedSpace)
  if ok and nowspace then
    pcall(hs.spaces.moveWindowToSpace, win, nowspace)
  end

  local screen = hs.screen.mainScreen() or win:screen()
  if not screen then
    utils.notify 'No screen available'
    return false
  end

  local max = screen:fullFrame()
  local f = win:frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h * (height or 1)

  -- Moving windows between Spaces can be asynchronous; resize shortly after the
  -- move so the frame lands on the target Space/screen instead of the old one.
  hs.timer.doAfter(0.2, function()
    pcall(function() win:setFrame(f) end)
  end)
  win:focus()
  return true
end

local function withAppMainWindow(bundleID, attemptsRemaining, fn)
  local app = hs.application.find(bundleID)
  local win = app and app:mainWindow()

  if win then
    fn(win, app)
    return true
  end

  if attemptsRemaining <= 0 then
    utils.notify('No window for ' .. (app and app:name() or bundleID))
    return false
  end

  hs.timer.doAfter(0.2, function()
    withAppMainWindow(bundleID, attemptsRemaining - 1, fn)
  end)
  return false
end

local function bindHotkey(bundleID, key, height)
  hs.hotkey.bind(utils.hyper, key, function()
    local app = hs.application.find(bundleID)

    if app and app:isFrontmost() then
      app:hide()
      return
    end

    if not hs.application.launchOrFocusByBundleID(bundleID) then
      utils.notify('Unable to launch ' .. bundleID)
      return
    end

    withAppMainWindow(bundleID, 10, function(win)
      moveWindowToCurrentSpace(win, height)
    end)
  end)
end

-- App Keybindings --

local cmuxBundleID = 'com.cmuxterm.app'
bindHotkey(cmuxBundleID, 't', 1) -- full screen cmux
hs.hotkey.bind(utils.hyper, 'b', function() launchOrHide 'company.thebrowser.Browser' end) -- Arc
hs.hotkey.bind(utils.hyper, 'f', function() launchOrHide 'com.DanPristupov.Fork' end) -- Fork

utils.notify 'Hammerspoon loaded'
