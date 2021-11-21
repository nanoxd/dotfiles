local utils = require('utils')
hs.window.animationDuration = 0

local windowMT = hs.getObjectMetatable("hs.window")
local window = hs.window

-- +-----------------+
-- |           |     |
-- |    HERE   |     |
-- |           |     |
-- +-----------------+
function windowMT.threeQuarterLeft(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.h = max.h

  if max.w > 1680 then
    f.w = max.w * 0.75
  else
    f.w = max.w * 0.67
  end

  win:setFrame(f)
end

-- +-----------------+
-- | H  |            |
-- | E  |            |
-- | RE |            |
-- +-----------------+
function windowMT.oneQuarterLeft(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.h = max.h

  if max.w > 1680 then
    f.w = max.w * 0.25
  else
    f.w = max.w * 0.33
  end

  win:setFrame(f)
end

-- +-----------------+
-- |    |            |
-- |    |    HERE    |
-- |    |            |
-- +-----------------+
function windowMT.threeQuarterRight(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  if max.w > 1680 then
    f.w = max.w * 0.75
  else
    f.w = max.w * 0.67
  end

  f.h = max.h
  f.x = max.x + (max.w - f.w)
  f.y = max.y
  win:setFrame(f)
end

-- +-----------------+
-- |           |  H  |
-- |           |  E  |
-- |           |  RE |
-- +-----------------+
function windowMT.oneQuarterRight(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  if max.w > 1680 then
    f.w = max.w * 0.25
  else
    f.w = max.w * 0.33
  end

  f.h = max.h
  f.x = max.x + (max.w - f.w)
  f.y = max.y
  win:setFrame(f)
end

-- +--------------+
-- |  |        |  |
-- |  |  HERE  |  |
-- |  |        |  |
-- +---------------+
function windowMT.centerWithFullHeight(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x + (max.w / 5)
  f.w = max.w * 3/5
  f.y = max.y
  f.h = max.h
  win:setFrame(f)
end

function windowMT.nextScreen(win)
  local currentScreen = win:screen()
  local allScreens = hs.screen.allScreens()
  currentScreenIndex = hs.fnutils.indexOf(allScreens, currentScreen)
  nextScreenIndex = currentScreenIndex + 1

  if allScreens[nextScreenIndex] then
    win:moveToScreen(allScreens[nextScreenIndex], true, true)
  else
    win:moveToScreen(allScreens[1], true, true)
  end
end

local hMovement = 40
local vMovement = 30

function windowMT.moveUp(win)
  local f = win:frame()

  f.y = f.y-vMovement
  win:setFrame(f)
end

function windowMT.moveDown(win)
  local f = win:frame()

  f.y = f.y+vMovement
  win:setFrame(f)
end

function windowMT.moveLeft(win)
  local f = win:frame()

  f.x = f.x-hMovement
  win:setFrame(f)
end

function windowMT.moveRight(win)
  local f = win:frame()

  f.x = f.x+hMovement
  win:setFrame(f)
end

function windowMT.enlargeUp(win)
  local f = win:frame()

  f.h = f.h+vMovement
  f.y = f.y-vMovement
  win:setFrame(f)
end

function windowMT.enlargeDown(win)
  local f = win:frame()

  f.h = f.h+vMovement
  win:setFrame(f)
end

function windowMT.enlargeLeft(win)
  local f = win:frame()

  f.w = f.w+hMovement
  f.x = f.x-hMovement
  win:setFrame(f)
end

function windowMT.enlargeRight(win)
  local f = win:frame()

  f.w = f.w+hMovement
  win:setFrame(f)
end

function windowMT.shrinkUp(win)
  local f = win:frame()

  f.h = f.h - vMovement
  win:setFrame(f)
end

function windowMT.shrinkDown(win)
  local f = win:frame()

  f.h = f.h - vMovement
  f.y = f.y + vMovement
  win:setFrame(f)
end

function windowMT.shrinkLeft(win)
  local f = win:frame()

  f.w = f.w - hMovement
  win:setFrame(f)
end

function windowMT.shrinkRight(win)
  local f = win:frame()

  f.w = f.w - hMovement
  f.x = f.x + hMovement
  win:setFrame(f)
end

--------------------------------------------------------------------------------
-- Define WindowLayout Mode
--
-- WindowLayout Mode allows you to manage window layout using keyboard shortcuts
-- that are on the home row, or very close to it. Use Control+s to turn
-- on WindowLayout mode. Then, use any shortcut below to perform a window layout
-- action. For example, to send the window left, press and release
-- Control+s, and then press h.
--
--   h/j/k/l => send window to the left/bottom/top/right half of the screen
--   i => send window to the upper left quarter of the screen
--   o => send window to the upper right quarter of the screen
--   , => send window to the lower left quarter of the screen
--   . => send window to the lower right quarter of the screen
--   return => make window full screen
--   n => send window to the next monitor
--   left => send window to the monitor on the left (if there is one)
--   right => send window to the monitor on the right (if there is one)
--------------------------------------------------------------------------------

windowLayoutMode = hs.hotkey.modal.new({}, 'F16')

local message = require('status-message')
windowLayoutMode.statusMessage = message.new('Window Layout Mode')
windowLayoutMode.entered = function()
  windowLayoutMode.statusMessage:show()
end
windowLayoutMode.exited = function()
  windowLayoutMode.statusMessage:hide()
end

-- Bind the given key to call the given function and exit WindowLayout mode
function windowLayoutMode.bindWithAutomaticExit(mode, key, fn)
  mode:bind({}, key, function()
    mode:exit()
    fn()
  end)
end

-- Bind the given key+modifiers to call the given function and exit WindowLayout mode
function windowLayoutMode.bindWithAutomaticExitAndMods(mode, mods, key, fn)
  mode:bind(mods, key, function()
    mode:exit()
    fn()
  end)
end

windowLayoutMode:bindWithAutomaticExit('return', function()
  hs.window.focusedWindow():maximize()
end)

windowLayoutMode:bindWithAutomaticExit('space', function()
  hs.window.focusedWindow():centerWithFullHeight()
end)

windowLayoutMode:bindWithAutomaticExit('h', function()
  window.focusedWindow():moveToUnit(hs.layout.left50)
end)

windowLayoutMode:bindWithAutomaticExit('j', function()
  window.focusedWindow():moveToUnit'[0,50,100,100]'
end)

windowLayoutMode:bindWithAutomaticExit('k', function()
  window.focusedWindow():moveToUnit'[0,0,100,50]'
end)

windowLayoutMode:bindWithAutomaticExit('l', function()
  window.focusedWindow():moveToUnit(hs.layout.right50)
end)

windowLayoutMode:bindWithAutomaticExit('i', function()
  window.focusedWindow():moveToUnit'[0,0,50,50]'
end)

windowLayoutMode:bindWithAutomaticExit('o', function()
  window.focusedWindow():moveToUnit'[50,0,100,50]'
end)

windowLayoutMode:bindWithAutomaticExit(',', function()
  window.focusedWindow():moveToUnit'[0,50,50,100]'
end)

windowLayoutMode:bindWithAutomaticExit('.', function()
  window.focusedWindow():moveToUnit'[50,50,100,100]'
end)

windowLayoutMode:bindWithAutomaticExit('y', function()
  hs.window.focusedWindow():threeQuarterLeft()
end)

windowLayoutMode:bindWithAutomaticExitAndMods({'shift'}, 'y', function()
  hs.window.focusedWindow():oneQuarterLeft()
end)

windowLayoutMode:bindWithAutomaticExit(';', function()
  hs.window.focusedWindow():threeQuarterRight()
end)

windowLayoutMode:bindWithAutomaticExitAndMods({'shift'}, ';', function()
  hs.window.focusedWindow():oneQuarterRight()
end)

windowLayoutMode:bindWithAutomaticExit('n', function()
  hs.window.focusedWindow():nextScreen()
end)

-- windowLayoutMode:bindWithAutomaticExit('right', function()
--   hs.window.focusedWindow():moveOneScreenEast()
-- end)
--
-- windowLayoutMode:bindWithAutomaticExit('left', function()
--   hs.window.focusedWindow():moveOneScreenWest()
-- end)

windowLayoutMode:bind({}, 'up', function ()
  hs.window.focusedWindow():moveUp()
end)

windowLayoutMode:bind({}, 'down', function ()
  hs.window.focusedWindow():moveDown()
end)

windowLayoutMode:bind({}, 'left', function ()
  hs.window.focusedWindow():moveLeft()
end)

windowLayoutMode:bind({}, 'right', function ()
  hs.window.focusedWindow():moveRight()
end)

windowLayoutMode:bind({'shift'}, 'up', function ()
  hs.window.focusedWindow():enlargeUp()
end)

windowLayoutMode:bind({'shift'}, 'down', function ()
  hs.window.focusedWindow():enlargeDown()
end)

windowLayoutMode:bind({'shift'}, 'left', function ()
  hs.window.focusedWindow():enlargeLeft()
end)

windowLayoutMode:bind({'shift'}, 'right', function ()
  hs.window.focusedWindow():enlargeRight()
end)

windowLayoutMode:bind({'shift', 'cmd'}, 'up', function ()
  hs.window.focusedWindow():shrinkUp()
end)

windowLayoutMode:bind({'shift', 'cmd'}, 'down', function ()
  hs.window.focusedWindow():shrinkDown()
end)

windowLayoutMode:bind({'shift', 'cmd'}, 'left', function ()
  hs.window.focusedWindow():shrinkLeft()
end)

windowLayoutMode:bind({'shift', 'cmd'}, 'right', function ()
  hs.window.focusedWindow():shrinkRight()
end)

-- Show keyboard hints for all windows
windowLayoutMode:bindWithAutomaticExit('/', function() 
  hs.hints.windowHints()
end)

windowLayoutMode:bindWithAutomaticExitAndMods({'shift'}, 'H', function() 
  window.switcher.nextWindow()
end)

-- Keybindings

hs.hotkey.bind(utils.hyper, 'z', function()
  windowLayoutMode:enter()
end)

windowLayoutMode:bind({}, 'escape', function()
  windowLayoutMode:exit()
end)

windowLayoutMode:bind(utils.hyper, 'z', function()
  windowLayoutMode:exit()
end)

