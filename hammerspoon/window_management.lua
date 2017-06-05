hs.window.animationDuration = 0

-- windowManagementBindings = {
--   -- Full Screen
--   {{'cmd', 'ctrl'}, 'i', '[0,0,100,100]'},
--   -- Left half
--   {{'cmd', 'ctrl'}, 'h', '[0,0,50,100]'},
--   -- Top half
--   {{'cmd', 'ctrl'}, 'k', '[0,0,100,50]'},
--   -- Bottom half
--   {{'cmd', 'ctrl'}, 'l', '[50,0,100,100]'},
--   -- Right half
--   {{'cmd', 'ctrl'}, 'j', '[0,50,100,100]'},
--
--   -- Left 2/3
--   {{'cmd', 'ctrl', 'shift'}, 'h', '[0,0,58,100]'},
--   -- Right 1/3
--   {{'cmd', 'ctrl', 'shift'}, 'l', '[58,0,100,100]'},
-- }
--
-- resizeWindow = function(size)
--   local win = hs.window.focusedWindow()
--   local originalSize = win:frame()
--   local screen = win:screen()
--
--   win:move(size)
--
--   -- If it hasn't moved, try the next screen
--   if originalSize:equals(win:frame()) and screen:id() ~= screen:next():id() then
--     win:move(size, screen:next())
--     -- Move it one more time as some windows don't quite get into place after
--     -- the first move
--     win:move(size)
--   end
-- end
--
-- for i, mapping in ipairs(windowManagementBindings) do
--   hs.hotkey.bind(mapping[1], mapping[2], function() resizeWindow(mapping[3]) end)
-- end

-- +-----------------+
-- |        |        |
-- |  HERE  |        |
-- |        |        |
-- +-----------------+
function hs.window.left(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

-- +-----------------+
-- |        |        |
-- |        |  HERE  |
-- |        |        |
-- +-----------------+
function hs.window.right(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

-- +-----------------+
-- |      HERE       |
-- +-----------------+
-- |                 |
-- +-----------------+
function hs.window.up(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.w = max.w
  f.y = max.y
  f.h = max.h / 2
  win:setFrame(f)
end

-- +-----------------+
-- |                 |
-- +-----------------+
-- |      HERE       |
-- +-----------------+
function hs.window.down(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.w = max.w
  f.y = max.y + (max.h / 2)
  f.h = max.h / 2
  win:setFrame(f)
end

-- +-----------------+
-- |  HERE  |        |
-- +--------+        |
-- |                 |
-- +-----------------+
function hs.window.upLeft(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x
  f.y = max.y
  f.w = max.w/2
  f.h = max.h/2
  win:setFrame(f)
end

-- +-----------------+
-- |                 |
-- +--------+        |
-- |  HERE  |        |
-- +-----------------+
function hs.window.downLeft(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w/2
  f.h = max.h/2
  win:setFrame(f)
end

-- +-----------------+
-- |                 |
-- |        +--------|
-- |        |  HERE  |
-- +-----------------+
function hs.window.downRight(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x + (max.w / 2)
  f.y = max.y + (max.h / 2)
  f.w = max.w/2
  f.h = max.h/2

  win:setFrame(f)
end

-- +-----------------+
-- |        |  HERE  |
-- |        +--------|
-- |                 |
-- +-----------------+
function hs.window.upRight(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w/2
  f.h = max.h/2
  win:setFrame(f)
end

-- +--------------+
-- |  |        |  |
-- |  |  HERE  |  |
-- |  |        |  |
-- +---------------+
function hs.window.centerWithFullHeight(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x + (max.w / 5)
  f.w = max.w * 3/5
  f.y = max.y
  f.h = max.h
  win:setFrame(f)
end

function hs.window.nextScreen(win)
  local currentScreen = win:screen()
  local allScreens = hs.screen.allScreens()
  currentScreenIndex = hs.fnutils.indexOf(allScreens, currentScreen)
  nextScreenIndex = currentScreenIndex + 1

  if allScreens[nextScreenIndex] then
    win:moveToScreen(allScreens[nextScreenIndex])
  else
    win:moveToScreen(allScreens[1])
  end
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

local message = require 'status_message'

windowLayoutMode.statusMessage = message.new('Window Layout Mode (Hyper-g)')
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

windowLayoutMode:bindWithAutomaticExit('return', function()
  hs.window.focusedWindow():maximize()
end)

windowLayoutMode:bindWithAutomaticExit('space', function()
  hs.window.focusedWindow():centerWithFullHeight()
end)

windowLayoutMode:bindWithAutomaticExit('h', function()
  hs.window.focusedWindow():left()
end)

windowLayoutMode:bindWithAutomaticExit('j', function()
  hs.window.focusedWindow():down()
end)

windowLayoutMode:bindWithAutomaticExit('k', function()
  hs.window.focusedWindow():up()
end)

windowLayoutMode:bindWithAutomaticExit('l', function()
  hs.window.focusedWindow():right()
end)

windowLayoutMode:bindWithAutomaticExit('i', function()
  hs.window.focusedWindow():upLeft()
end)

windowLayoutMode:bindWithAutomaticExit('o', function()
  hs.window.focusedWindow():upRight()
end)

windowLayoutMode:bindWithAutomaticExit(',', function()
  hs.window.focusedWindow():downLeft()
end)

windowLayoutMode:bindWithAutomaticExit('.', function()
  hs.window.focusedWindow():downRight()
end)

windowLayoutMode:bindWithAutomaticExit('n', function()
  hs.window.focusedWindow():nextScreen()
end)

windowLayoutMode:bindWithAutomaticExit('right', function()
  hs.window.focusedWindow():moveOneScreenEast()
end)

windowLayoutMode:bindWithAutomaticExit('left', function()
  hs.window.focusedWindow():moveOneScreenWest()
end)

-- Use hyper+g to toggle WindowLayout Mode
hs.hotkey.bind(hyper, 'g', function()
  windowLayoutMode:enter()
end)

windowLayoutMode:bind(hyper, 'g', function()
  windowLayoutMode:exit()
end)
