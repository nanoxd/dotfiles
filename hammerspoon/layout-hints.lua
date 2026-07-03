-- Cheat-sheet overlay for WindowLayout mode.
--
-- Renders a centered panel listing every key binding grouped by purpose, so the
-- available actions are explicit while the mode is active. Each row pairs the
-- key(s) to press with a small pictogram of the resulting window layout — the
-- pictograms are drawn with hs.canvas primitives, in the spirit of Moom's
-- keyboard cheat sheet. Built on hs.canvas like status-message.lua.

local canvas = require 'hs.canvas'

local hints = {}

-- Palette --------------------------------------------------------------------
local COLOR_PANEL = { red = 0.09, green = 0.10, blue = 0.13, alpha = 0.94 }
local COLOR_BORDER = { white = 1.0, alpha = 0.09 }
local COLOR_DIVIDER = { white = 1.0, alpha = 0.10 }
local COLOR_TITLE = { white = 1.0, alpha = 0.96 }
local COLOR_ACCENT = { red = 0.902, green = 0.706, blue = 0.314, alpha = 1.0 }
local COLOR_HEADER = { white = 1.0, alpha = 0.42 }
local COLOR_DESC = { white = 1.0, alpha = 0.82 }
local COLOR_ICON_LINE = { white = 1.0, alpha = 0.34 }
local COLOR_ICON_FILL = { white = 1.0, alpha = 0.80 }

-- Typography -----------------------------------------------------------------
local TITLE_FONT = 'Helvetica Neue'
local TEXT_FONT = 'Helvetica Neue'
-- Iosevka Nano is monospace with full coverage of the modifier/arrow glyphs
-- (⇧ ⌘ ⏎ ␣ ← ↓ ↑ →), so the key column stays aligned. Menlo lacks several of
-- these and would substitute a proportional fallback for them.
local KEY_FONT = 'Iosevka Nano'
local TITLE_SIZE = 20
local HINT_SIZE = 13
local HEADER_SIZE = 11
local KEY_SIZE = 14
local DESC_SIZE = 14

-- Layout metrics -------------------------------------------------------------
local PANEL_PADDING = 26
local COL_GAP = 30
local KEY_COL_W = 92
local KEY_ICON_GAP = 10
local ICON_W = 26
local ICON_H = 17
local ICON_DESC_GAP = 10
local DESC_COL_W = 104
local ROW_H = 26
local HEADER_H = 24
local SECTION_GAP = 14
local TITLE_H = 44
local CORNER = 16

local COL_W = KEY_COL_W + KEY_ICON_GAP + ICON_W + ICON_DESC_GAP + DESC_COL_W

-- Pictograms -----------------------------------------------------------------
-- Positional layouts: a "screen" outline with a filled window sub-rectangle,
-- expressed as {x, y, w, h} fractions of the inner screen area.
local FRAMED = {
  leftHalf = { 0, 0, 0.5, 1 },
  rightHalf = { 0.5, 0, 0.5, 1 },
  topHalf = { 0, 0, 1, 0.5 },
  bottomHalf = { 0, 0.5, 1, 0.5 },
  topLeft = { 0, 0, 0.5, 0.5 },
  topRight = { 0.5, 0, 0.5, 0.5 },
  bottomLeft = { 0, 0.5, 0.5, 0.5 },
  bottomRight = { 0.5, 0.5, 0.5, 0.5 },
  tqLeft = { 0, 0, 0.75, 1 },
  oqLeft = { 0, 0, 0.25, 1 },
  tqRight = { 0.25, 0, 0.75, 1 },
  oqRight = { 0.75, 0, 0.25, 1 },
  center = { 0.2, 0, 0.6, 1 },
  maximize = { 0, 0, 1, 1 },
}

local function screenOutline(x, y)
  return {
    type = 'rectangle',
    action = 'stroke',
    strokeColor = COLOR_ICON_LINE,
    strokeWidth = 1,
    roundedRectRadii = { xRadius = 2.5, yRadius = 2.5 },
    frame = { x = x, y = y, w = ICON_W, h = ICON_H },
  }
end

local function triangle(a, b, c)
  return {
    type = 'segments',
    closed = true,
    action = 'fill',
    fillColor = COLOR_ICON_FILL,
    coordinates = { a, b, c },
  }
end

-- Append the pictogram for `kind` at the absolute canvas point (x, y).
local function appendIcon(add, kind, x, y)
  local W, H = ICON_W, ICON_H
  local frac = FRAMED[kind]

  if frac then
    add(screenOutline(x, y))
    local pad = 2
    local sx, sy, sw, sh = x + pad, y + pad, W - 2 * pad, H - 2 * pad
    add {
      type = 'rectangle',
      action = 'fill',
      fillColor = COLOR_ICON_FILL,
      roundedRectRadii = { xRadius = 1.5, yRadius = 1.5 },
      frame = { x = sx + frac[1] * sw, y = sy + frac[2] * sh, w = frac[3] * sw, h = frac[4] * sh },
    }
    return
  end

  if kind == 'move' then
    -- Orthogonal 4-way arrows around a small center block: translate window.
    local cx, cy = x + W / 2, y + H / 2
    local a, len = 3.2, 5
    add {
      type = 'rectangle',
      action = 'fill',
      fillColor = COLOR_ICON_FILL,
      roundedRectRadii = { xRadius = 1, yRadius = 1 },
      frame = { x = cx - 2.5, y = cy - 2.5, w = 5, h = 5 },
    }
    add(triangle({ x = cx, y = y + 0.5 }, { x = cx - a, y = y + 0.5 + len }, { x = cx + a, y = y + 0.5 + len }))
    add(triangle({ x = cx, y = y + H - 0.5 }, { x = cx - a, y = y + H - 0.5 - len }, { x = cx + a, y = y + H - 0.5 - len }))
    add(triangle({ x = x + 0.5, y = cy }, { x = x + 0.5 + len, y = cy - a }, { x = x + 0.5 + len, y = cy + a }))
    add(triangle({ x = x + W - 0.5, y = cy }, { x = x + W - 0.5 - len, y = cy - a }, { x = x + W - 0.5 - len, y = cy + a }))
    return
  end

  if kind == 'enlarge' or kind == 'shrink' then
    -- Same diagonal cut at each corner; enlarge fills the outer wedge (grow),
    -- shrink fills the inner wedge (contract).
    add(screenOutline(x, y))
    local m, s = 2.5, 7
    local outer = kind == 'enlarge'
    local function corner(ox, oy, dx, dy)
      local px, py = x + ox, y + oy -- outer corner
      if outer then
        add(triangle({ x = px, y = py }, { x = px + dx * s, y = py }, { x = px, y = py + dy * s }))
      else
        add(triangle({ x = px + dx * s, y = py }, { x = px, y = py + dy * s }, { x = px + dx * s, y = py + dy * s }))
      end
    end
    corner(m, m, 1, 1)
    corner(W - m, m, -1, 1)
    corner(m, H - m, 1, -1)
    corner(W - m, H - m, -1, -1)
    return
  end

  if kind == 'nextWindow' then
    -- Two stacked windows.
    add {
      type = 'rectangle',
      action = 'stroke',
      strokeColor = COLOR_ICON_LINE,
      strokeWidth = 1,
      roundedRectRadii = { xRadius = 2, yRadius = 2 },
      frame = { x = x, y = y + 1, w = W - 7, h = H - 7 },
    }
    add {
      type = 'rectangle',
      action = 'fill',
      fillColor = COLOR_ICON_FILL,
      roundedRectRadii = { xRadius = 2, yRadius = 2 },
      frame = { x = x + 7, y = y + 7, w = W - 7, h = H - 7 },
    }
    return
  end

  if kind == 'nextMonitor' then
    -- Two displays side by side, target (filled) on the right.
    local gap = 3
    local sw = (W - gap) / 2
    add {
      type = 'rectangle',
      action = 'stroke',
      strokeColor = COLOR_ICON_LINE,
      strokeWidth = 1,
      roundedRectRadii = { xRadius = 2, yRadius = 2 },
      frame = { x = x, y = y + 2, w = sw, h = H - 4 },
    }
    add {
      type = 'rectangle',
      action = 'stroke',
      strokeColor = COLOR_ICON_LINE,
      strokeWidth = 1,
      roundedRectRadii = { xRadius = 2, yRadius = 2 },
      frame = { x = x + sw + gap, y = y + 2, w = sw, h = H - 4 },
    }
    add {
      type = 'rectangle',
      action = 'fill',
      fillColor = COLOR_ICON_FILL,
      roundedRectRadii = { xRadius = 1, yRadius = 1 },
      frame = { x = x + sw + gap + 2, y = y + 4, w = sw - 4, h = H - 8 },
    }
    return
  end

  if kind == 'hints' then
    -- Screen sprinkled with hint markers.
    add(screenOutline(x, y))
    for _, p in ipairs { { 4, 4 }, { W / 2 - 2, H / 2 - 2 }, { W - 8, H - 8 } } do
      add {
        type = 'rectangle',
        action = 'fill',
        fillColor = COLOR_ICON_FILL,
        roundedRectRadii = { xRadius = 1, yRadius = 1 },
        frame = { x = x + p[1], y = y + p[2], w = 4, h = 4 },
      }
    end
    return
  end
end

-- Content --------------------------------------------------------------------
-- Three columns, each a list of sections mirroring the bindings in windows.lua.
local columns = {
  {
    {
      title = 'Halves',
      rows = {
        { key = 'H', icon = 'leftHalf', desc = 'Left' },
        { key = 'J', icon = 'bottomHalf', desc = 'Bottom' },
        { key = 'K', icon = 'topHalf', desc = 'Top' },
        { key = 'L', icon = 'rightHalf', desc = 'Right' },
      },
    },
    {
      title = 'Quarters',
      rows = {
        { key = 'I', icon = 'topLeft', desc = 'Top left' },
        { key = 'O', icon = 'topRight', desc = 'Top right' },
        { key = ',', icon = 'bottomLeft', desc = 'Bottom left' },
        { key = '.', icon = 'bottomRight', desc = 'Bottom right' },
      },
    },
  },
  {
    {
      title = 'Fractions',
      rows = {
        { key = 'Y', icon = 'tqLeft', desc = '¾ left' },
        { key = '⇧Y', icon = 'oqLeft', desc = '¼ left' },
        { key = ';', icon = 'tqRight', desc = '¾ right' },
        { key = '⇧;', icon = 'oqRight', desc = '¼ right' },
      },
    },
    {
      title = 'Size',
      rows = {
        { key = '␣', icon = 'center', desc = 'Center' },
        { key = '⏎', icon = 'maximize', desc = 'Maximize' },
      },
    },
  },
  {
    {
      title = 'Move & Resize',
      rows = {
        { key = '←↓↑→', icon = 'move', desc = 'Move' },
        { key = '⇧ ←↓↑→', icon = 'enlarge', desc = 'Enlarge' },
        { key = '⇧⌘ ←↓↑→', icon = 'shrink', desc = 'Shrink' },
      },
    },
    {
      title = 'Windows & Display',
      rows = {
        { key = '⇧H', icon = 'nextWindow', desc = 'Next window' },
        { key = 'N', icon = 'nextMonitor', desc = 'Next monitor' },
        { key = '/', icon = 'hints', desc = 'Show hints' },
      },
    },
  },
}

-- Geometry -------------------------------------------------------------------
local function sectionHeight(section)
  return HEADER_H + #section.rows * ROW_H
end

local function columnHeight(sections)
  local h = 0
  for i, section in ipairs(sections) do
    h = h + sectionHeight(section)
    if i < #sections then
      h = h + SECTION_GAP
    end
  end
  return h
end

local function contentHeight()
  local maxH = 0
  for _, sections in ipairs(columns) do
    maxH = math.max(maxH, columnHeight(sections))
  end
  return maxH
end

local PANEL_W = PANEL_PADDING * 2 + #columns * COL_W + (#columns - 1) * COL_GAP

local function panelHeight()
  return PANEL_PADDING * 2 + TITLE_H + contentHeight()
end

-- Rendering ------------------------------------------------------------------
local function targetScreen()
  local win = hs.window.focusedWindow()
  if win and win:screen() then
    return win:screen()
  end
  return hs.screen.mainScreen()
end

local function buildCanvas()
  local screen = targetScreen()
  local sf = screen:frame()
  local w = PANEL_W
  local h = panelHeight()
  local x = sf.x + (sf.w - w) / 2
  local y = sf.y + (sf.h - h) / 2

  local c = canvas.new { x = x, y = y, w = w, h = h }
  local els = {}
  local function add(el)
    els[#els + 1] = el
  end

  -- Panel background and border.
  add {
    type = 'rectangle',
    action = 'fill',
    roundedRectRadii = { xRadius = CORNER, yRadius = CORNER },
    fillColor = COLOR_PANEL,
  }
  add {
    type = 'rectangle',
    action = 'stroke',
    roundedRectRadii = { xRadius = CORNER, yRadius = CORNER },
    strokeColor = COLOR_BORDER,
    strokeWidth = 1,
  }

  -- Title with exit hint, and a divider beneath it.
  add {
    type = 'text',
    text = 'Window Layout',
    textFont = TITLE_FONT,
    textSize = TITLE_SIZE,
    textColor = COLOR_TITLE,
    textAlignment = 'left',
    frame = { x = PANEL_PADDING, y = PANEL_PADDING - 2, w = PANEL_W - PANEL_PADDING * 2, h = TITLE_SIZE + 8 },
  }
  add {
    type = 'text',
    text = '⎋ exit',
    textFont = TEXT_FONT,
    textSize = HINT_SIZE,
    textColor = COLOR_HEADER,
    textAlignment = 'right',
    frame = { x = PANEL_PADDING, y = PANEL_PADDING + 3, w = PANEL_W - PANEL_PADDING * 2, h = TITLE_SIZE },
  }
  add {
    type = 'rectangle',
    action = 'fill',
    fillColor = COLOR_DIVIDER,
    frame = { x = PANEL_PADDING, y = PANEL_PADDING + TITLE_H - 12, w = PANEL_W - PANEL_PADDING * 2, h = 1 },
  }

  -- Columns of sections.
  local contentTop = PANEL_PADDING + TITLE_H
  for colIndex, sections in ipairs(columns) do
    local colX = PANEL_PADDING + (colIndex - 1) * (COL_W + COL_GAP)
    local cursorY = contentTop

    for _, section in ipairs(sections) do
      add {
        type = 'text',
        text = string.upper(section.title),
        textFont = TEXT_FONT,
        textSize = HEADER_SIZE,
        textColor = COLOR_HEADER,
        textAlignment = 'left',
        frame = { x = colX, y = cursorY, w = COL_W, h = HEADER_H },
      }
      cursorY = cursorY + HEADER_H

      for _, row in ipairs(section.rows) do
        add {
          type = 'text',
          text = row.key,
          textFont = KEY_FONT,
          textSize = KEY_SIZE,
          textColor = COLOR_ACCENT,
          textAlignment = 'right',
          frame = { x = colX, y = cursorY + 4, w = KEY_COL_W, h = ICON_H },
        }
        appendIcon(add, row.icon, colX + KEY_COL_W + KEY_ICON_GAP, cursorY + math.floor((ROW_H - ICON_H) / 2))
        add {
          type = 'text',
          text = row.desc,
          textFont = TEXT_FONT,
          textSize = DESC_SIZE,
          textColor = COLOR_DESC,
          textAlignment = 'left',
          frame = {
            x = colX + KEY_COL_W + KEY_ICON_GAP + ICON_W + ICON_DESC_GAP,
            y = cursorY + 4,
            w = DESC_COL_W,
            h = ICON_H,
          },
        }
        cursorY = cursorY + ROW_H
      end

      cursorY = cursorY + SECTION_GAP
    end
  end

  c:appendElements(table.unpack(els))
  return c
end

-- Public API -----------------------------------------------------------------
hints.new = function()
  return {
    canvas = nil,
    show = function(self)
      self:hide()
      self.canvas = buildCanvas()
      self.canvas:show(0.12)
    end,
    hide = function(self)
      if self.canvas then
        self.canvas:delete()
        self.canvas = nil
      end
    end,
  }
end

return hints
