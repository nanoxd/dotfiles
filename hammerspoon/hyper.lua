-- Hyper+key for all the below are setup somewhere
-- The handler already exists, usually in app
-- we just have to get the right keystroke sent
hyperBindings = {'s', 't', 'w', 'a', 'SPACE'}

for i, key in ipairs(hyperBindings) do
  hyperMode:bind({}, key, nil, function()
    hs.eventtap.keyStroke(hyper, key)
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
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)
