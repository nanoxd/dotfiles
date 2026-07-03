local utils = {}

utils.hyper = { '⌘', '⌥', '⌃', '⇧' }

-- Ordered preference list of monospace fonts. Ends with faces that ship with
-- every macOS, so resolveFont always finds something usable.
utils.monospaceFonts = {
  'Iosevka Nano', -- personal Iosevka build
  'Iosevka NFM', -- Iosevka Nerd Font Mono
  'Iosevka Term',
  'Iosevka',
  'JetBrains Mono',
  'Fira Code',
  'SF Mono',
  'Menlo',
  'Monaco',
}

-- Return the first installed font family from `candidates`. macOS (and thus
-- hs.canvas / hs.alert) takes a single font name and silently substitutes a
-- proportional default when it is unknown, so we resolve a real family at load
-- time instead of relying on a CSS-style fallback list, which does not exist
-- here. The last candidate should be a font that always ships with macOS.
function utils.resolveFont(candidates)
  local families = {}
  for _, name in ipairs(hs.styledtext.fontFamilies()) do
    families[name] = true
  end
  for _, name in ipairs(candidates) do
    if families[name] then
      return name
    end
  end
  return candidates[#candidates]
end

return utils
