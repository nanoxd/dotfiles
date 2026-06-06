local canvas = require 'hs.canvas'
local hsscreen = require 'hs.screen'

local statusmessage = {}

-- Text appearance, shared between measurement and rendering so the box is
-- always sized for exactly what gets drawn.
local FONT = 'Helvetica Neue'
local FONT_SIZE = 48
local H_PADDING = 24
local V_PADDING = 12

-- Measure the text using the *same* font and size we render with. Measuring on
-- a screen-sized canvas avoids any wrapping, and setting textFont/textSize on
-- the element makes minimumTextSize use them instead of the canvas default
-- (27pt) — otherwise the box is sized for 27pt text while 48pt text is drawn
-- into it and gets clipped to "Wind…".
local function measureText(messageText, screenFrame)
  local c = canvas.new { x = 0, y = 0, w = screenFrame.w, h = screenFrame.h }
  c:appendElements {
    type = 'text',
    text = messageText,
    textFont = FONT,
    textSize = FONT_SIZE,
  }
  local size = c:minimumTextSize(1, messageText)
  c:delete()
  return size
end

statusmessage.new = function(messageText)
  local buildCanvases = function(messageText)
    local canvases = {}
    local screens = hsscreen.allScreens()

    for idx, screen in ipairs(screens) do
      local frame = screen:frame()

      local textSize = measureText(messageText, frame)

      local w = textSize.w + H_PADDING * 2
      local h = textSize.h + V_PADDING * 2
      local x = frame.x + frame.w - w - 10
      local y = frame.y + frame.h - h - 20

      local c = canvas.new { x = x, y = y, w = w, h = h }
      c:appendElements(
        {
          type = 'rectangle',
          roundedRectRadii = { xRadius = 10, yRadius = 10 },
          fillColor = { red = 0, green = 0, blue = 0, alpha = 0.8 },
        },
        {
          type = 'text',
          text = messageText,
          textFont = FONT,
          textSize = FONT_SIZE,
          textColor = { white = 1.0, alpha = 0.7 },
          textAlignment = 'center',
          frame = { x = 0, y = V_PADDING, w = w, h = textSize.h },
        }
      )

      canvases[idx] = c
    end
    return canvases
  end

  return {
    _buildCanvases = buildCanvases,
    show = function(self)
      self:hide()

      self.canvases = self._buildCanvases(messageText)
      for _, c in ipairs(self.canvases) do
        c:show()
      end
    end,
    hide = function(self)
      if self.canvases then
        for _, c in ipairs(self.canvases) do
          c:delete()
        end
        self.canvases = nil
      end
    end,
    notify = function(self, seconds)
      local seconds = seconds or 2
      self:show()
      hs.timer.delayed.new(seconds, function() self:hide() end):start()
    end,
  }
end

return statusmessage
