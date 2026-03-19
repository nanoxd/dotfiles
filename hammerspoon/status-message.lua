local canvas = require 'hs.canvas'
local hsscreen = require 'hs.screen'

local statusmessage = {}
statusmessage.new = function(messageText)
  local buildCanvases = function(messageText)
    local canvases = {}
    local screens = hsscreen.allScreens()

    for idx, screen in ipairs(screens) do
      local frame = screen:frame()

      local textStyle = {
        font = { name = 'Helvetica Neue', size = 48 },
        color = { white = 1.0, alpha = 0.7 },
      }
      local textSize = canvas.new({ x = 0, y = 0, w = 0, h = 0 }):appendElements({
        type = 'text',
        text = hs.styledtext.new(messageText, textStyle),
      }):minimumTextSize(1, messageText)

      local w = textSize.w + 40
      local h = textSize.h + 6
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
          text = hs.styledtext.new(messageText, textStyle),
          frame = { x = '10%', y = '0%', w = '90%', h = '100%' },
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
