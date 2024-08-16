local utils = require("utils")
hyperBindings = { "s", "w", "a", "g", "t", "SPACE" }

for i, key in ipairs(hyperBindings) do
  hyperMode:bind({}, key, nil, function()
    hs.eventtap.keyStroke(utils.hyper, key)
    hyperMode.triggered = true
  end)
end

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  hyperMode.triggered = false
  hyperMode:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  hyperMode:exit()
  if not hyperMode.triggered then
    hs.eventtap.keyStroke({}, "ESCAPE")
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, "F18", pressedF18, releasedF18)
