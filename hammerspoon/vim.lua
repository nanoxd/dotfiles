local M = {}
-- Modal ViM
local function keyCode(key)
  return function() hs.eventtap.keyStroke({}, key) end
end

function M.load ()
  hs.hotkey.bind({"cmd", "alt"}, 'h', keyCode('left') ,  nil,   keyCode('left'))
  hs.hotkey.bind({"cmd", "alt"}, 'j', keyCode('down') ,  nil,   keyCode('down') )
  hs.hotkey.bind({"cmd", "alt"}, 'k', keyCode('up')   ,  nil,   keyCode('up') )
  hs.hotkey.bind({"cmd", "alt"}, 'l', keyCode('right'),  nil,   keyCode('right') )

  modalVimMode = hs.hotkey.modal.new({"cmd", "alt"}, '\\', "Vimificating")
  modalVimMode:bind({}, 'h', keyCode('left') ,  nil, keyCode('left')  )
  modalVimMode:bind({}, 'j', keyCode('down') ,  nil, keyCode('down')  )
  modalVimMode:bind({}, 'k', keyCode('up')   ,  nil, keyCode('up')    )
  modalVimMode:bind({}, 'l', keyCode('right'),  nil, keyCode('right') )

  function modalVimMode:exited()
    -- hs.screen.primaryScreen():setGamma({alpha=1.0,red=0.0,green=0.0,blue=0.0},{blue=1.0,green=1.0,red=1.0})
    hs.alert.show("No ViM mode")
  end

  modalVimMode:bind({}, 'escape', function() modalVimMode:exit() end)
end

return M
