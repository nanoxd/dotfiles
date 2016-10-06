local M = {}

local hyper = {"⌘", "⌥", "⌃", "⇧"}

function M.load()
  -- A global variable for the Hyper Mode
  k = hs.hotkey.modal.new({}, "F17")

  -- Hyper+key for all the below are setup somewhere
  -- The handler already exists, usually in Keyboard Maestro
  -- we just have to get the right keystroke sent
  hyperBindings = {'s', 't', 'w', 'SPACE'}

  k:bind({}, 'Q', 'Lock System', function() hs.caffeinate.lockScreen() end)

  for i,key in ipairs(hyperBindings) do
    k:bind({}, key, nil, function() hs.eventtap.keyStroke(hyper, key)
      k.triggered = true
    end)
  end

  -- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
  pressedF18 = function()
    k.triggered = false
    k:enter()
  end

  -- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
  --   send ESCAPE if no other keys are pressed.
  releasedF18 = function()
    k:exit()
    if not k.triggered then
      hs.eventtap.keyStroke({}, 'ESCAPE')
    end
  end

  -- Bind the Hyper key
  f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)
end


return M
