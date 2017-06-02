hs.window.animationDuration = 0

windowManagementBindings = {
  -- Full Screen
  {{'cmd', 'ctrl'}, 'i', '[0,0,100,100]'},
  -- Left half
  {{'cmd', 'ctrl'}, 'h', '[0,0,50,100]'},
  -- Top half
  {{'cmd', 'ctrl'}, 'k', '[0,0,100,50]'},
  -- Bottom half
  {{'cmd', 'ctrl'}, 'l', '[50,0,100,100]'},
  -- Right half
  {{'cmd', 'ctrl'}, 'j', '[0,50,100,100]'},

  -- Left 2/3
  {{'cmd', 'ctrl', 'shift'}, 'h', '[0,0,58,100]'},
  -- Right 1/3
  {{'cmd', 'ctrl', 'shift'}, 'l', '[58,0,100,100]'},
}

resizeWindow = function(size)
  local win = hs.window.focusedWindow()
  local originalSize = win:frame()
  local screen = win:screen()

  win:move(size)

  -- If it hasn't moved, try the next screen
  if originalSize:equals(win:frame()) and screen:id() ~= screen:next():id() then
    win:move(size, screen:next())
    -- Move it one more time as some windows don't quite get into place after
    -- the first move
    win:move(size)
  end
end

for i, mapping in ipairs(windowManagementBindings) do
  hs.hotkey.bind(mapping[1], mapping[2], function() resizeWindow(mapping[3]) end)
end
