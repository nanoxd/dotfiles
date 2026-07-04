local utils = require 'utils'
hs.window.animationDuration = 0

local windowMT = hs.getObjectMetatable 'hs.window'
local window = hs.window

local function focusedWindowAction(fn)
  return function()
    utils.withFocusedWindow(fn)
  end
end

-- Place the window flush against one edge of the screen, sized to `fraction`
-- of the screen along that edge's axis and spanning the full extent of the
-- other axis. This backs the "direction picks the edge, modifier picks the
-- fraction" bindings defined further down.
function windowMT.placeEdge(win, edge, fraction)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  if edge == 'left' then
    f.x, f.y, f.w, f.h = max.x, max.y, max.w * fraction, max.h
  elseif edge == 'right' then
    f.w, f.h = max.w * fraction, max.h
    f.x, f.y = max.x + (max.w - f.w), max.y
  elseif edge == 'top' then
    f.x, f.y, f.w, f.h = max.x, max.y, max.w, max.h * fraction
  elseif edge == 'bottom' then
    f.w, f.h = max.w, max.h * fraction
    f.x, f.y = max.x, max.y + (max.h - f.h)
  end

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
  f.w = max.w * 3 / 5
  f.y = max.y
  f.h = max.h
  win:setFrame(f)
end

-- Center a full-height column that is `fraction` of the screen wide. Extends the
-- edge model's fractions to the center (focus) position via shift/option+space.
function windowMT.centerFraction(win, fraction)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = max.w * fraction
  f.h = max.h
  f.x = max.x + (max.w - f.w) / 2
  f.y = max.y
  win:setFrame(f)
end

function windowMT.nextScreen(win)
  local currentScreen = win:screen()
  local allScreens = hs.screen.allScreens()
  local currentScreenIndex = hs.fnutils.indexOf(allScreens, currentScreen)

  if not currentScreenIndex or #allScreens == 0 then
    utils.notify 'No next screen available'
    return
  end

  local nextScreenIndex = currentScreenIndex + 1
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

  f.y = f.y - vMovement
  win:setFrame(f)
end

function windowMT.moveDown(win)
  local f = win:frame()

  f.y = f.y + vMovement
  win:setFrame(f)
end

function windowMT.moveLeft(win)
  local f = win:frame()

  f.x = f.x - hMovement
  win:setFrame(f)
end

function windowMT.moveRight(win)
  local f = win:frame()

  f.x = f.x + hMovement
  win:setFrame(f)
end

function windowMT.enlargeUp(win)
  local f = win:frame()

  f.h = f.h + vMovement
  f.y = f.y - vMovement
  win:setFrame(f)
end

function windowMT.enlargeDown(win)
  local f = win:frame()

  f.h = f.h + vMovement
  win:setFrame(f)
end

function windowMT.enlargeLeft(win)
  local f = win:frame()

  f.w = f.w + hMovement
  f.x = f.x - hMovement
  win:setFrame(f)
end

function windowMT.enlargeRight(win)
  local f = win:frame()

  f.w = f.w + hMovement
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
-- WindowLayout Mode manages window layout with home-row keyboard shortcuts.
-- Enter it with the hyper + z binding at the bottom of this file, then press a
-- shortcut. For example, to send the window left, press hyper+z, then h.
--
-- Placement follows "direction picks the edge, modifier picks the fraction":
--
--   h / l / k / j       => left / right / top / bottom edge
--   (no modifier) => 1/2   shift => 1/3   option => 2/3
--   control => 1/4         command => 3/4
--
--   e.g. l = right half, shift+l = right third, command+h = left three-quarters,
--   shift+k = top third.
--
-- Everything that isn't a single edge + fraction keeps its own key:
--
--   i / o / , / .  => upper-left / upper-right / lower-left / lower-right quarter
--   space          => center (focus); shift / option + space => center 1/3 or 2/3
--   return         => full screen
--   n              => next monitor
--   tab            => next window
--   /              => keyboard hints for all windows
--   arrows              => nudge the window
--   shift + arrows      => grow the window
--   shift + cmd + arrows => shrink the window
--   escape         => leave the mode
--------------------------------------------------------------------------------

windowLayoutMode = hs.hotkey.modal.new({}, 'F16')

local layoutHints = require 'layout-hints'
windowLayoutMode.hints = layoutHints.new()
windowLayoutMode.entered = function() windowLayoutMode.hints:show() end
windowLayoutMode.exited = function() windowLayoutMode.hints:hide() end

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

-- Placement: direction picks the edge, modifier picks the fraction.
local edgeKeys = {
  { key = 'h', edge = 'left' },
  { key = 'l', edge = 'right' },
  { key = 'k', edge = 'top' },
  { key = 'j', edge = 'bottom' },
}

local fractionMods = {
  { mods = {}, fraction = 1 / 2 },
  { mods = { 'shift' }, fraction = 1 / 3 },
  { mods = { 'alt' }, fraction = 2 / 3 },
  { mods = { 'ctrl' }, fraction = 1 / 4 },
  { mods = { 'cmd' }, fraction = 3 / 4 },
}

for _, e in ipairs(edgeKeys) do
  for _, m in ipairs(fractionMods) do
    local edge = e.edge
    local fraction = m.fraction
    windowLayoutMode:bindWithAutomaticExitAndMods(
      m.mods,
      e.key,
      focusedWindowAction(function(win) win:placeEdge(edge, fraction) end)
    )
  end
end

windowLayoutMode:bindWithAutomaticExit('return', focusedWindowAction(function(win) win:maximize() end))

windowLayoutMode:bindWithAutomaticExit('space', focusedWindowAction(function(win) win:centerWithFullHeight() end))

windowLayoutMode:bindWithAutomaticExitAndMods(
  { 'shift' },
  'space',
  focusedWindowAction(function(win) win:centerFraction(1 / 3) end)
)

windowLayoutMode:bindWithAutomaticExitAndMods(
  { 'alt' },
  'space',
  focusedWindowAction(function(win) win:centerFraction(2 / 3) end)
)

-- Corner quarters: a 2-D split, so outside the edge + fraction model.
windowLayoutMode:bindWithAutomaticExit('i', focusedWindowAction(function(win) win:moveToUnit '[0,0,50,50]' end))

windowLayoutMode:bindWithAutomaticExit('o', focusedWindowAction(function(win) win:moveToUnit '[50,0,100,50]' end))

windowLayoutMode:bindWithAutomaticExit(',', focusedWindowAction(function(win) win:moveToUnit '[0,50,50,100]' end))

windowLayoutMode:bindWithAutomaticExit('.', focusedWindowAction(function(win) win:moveToUnit '[50,50,100,100]' end))

windowLayoutMode:bindWithAutomaticExit('n', focusedWindowAction(function(win) win:nextScreen() end))

windowLayoutMode:bindWithAutomaticExit('tab', function() window.switcher.nextWindow() end)

windowLayoutMode:bind({}, 'up', focusedWindowAction(function(win) win:moveUp() end))

windowLayoutMode:bind({}, 'down', focusedWindowAction(function(win) win:moveDown() end))

windowLayoutMode:bind({}, 'left', focusedWindowAction(function(win) win:moveLeft() end))

windowLayoutMode:bind({}, 'right', focusedWindowAction(function(win) win:moveRight() end))

windowLayoutMode:bind({ 'shift' }, 'up', focusedWindowAction(function(win) win:enlargeUp() end))

windowLayoutMode:bind({ 'shift' }, 'down', focusedWindowAction(function(win) win:enlargeDown() end))

windowLayoutMode:bind({ 'shift' }, 'left', focusedWindowAction(function(win) win:enlargeLeft() end))

windowLayoutMode:bind({ 'shift' }, 'right', focusedWindowAction(function(win) win:enlargeRight() end))

windowLayoutMode:bind({ 'shift', 'cmd' }, 'up', focusedWindowAction(function(win) win:shrinkUp() end))

windowLayoutMode:bind({ 'shift', 'cmd' }, 'down', focusedWindowAction(function(win) win:shrinkDown() end))

windowLayoutMode:bind({ 'shift', 'cmd' }, 'left', focusedWindowAction(function(win) win:shrinkLeft() end))

windowLayoutMode:bind({ 'shift', 'cmd' }, 'right', focusedWindowAction(function(win) win:shrinkRight() end))

-- Show keyboard hints for all windows
windowLayoutMode:bindWithAutomaticExit('/', function() hs.hints.windowHints() end)

-- Keybindings

hs.hotkey.bind(utils.hyper, 'z', function() windowLayoutMode:enter() end)

windowLayoutMode:bind({}, 'escape', function() windowLayoutMode:exit() end)

windowLayoutMode:bind(utils.hyper, 'z', function() windowLayoutMode:exit() end)
