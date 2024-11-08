local wezterm = require 'wezterm'
local session_manager = require 'wezterm-session-manager/session-manager'
local act = wezterm.action

local mod = {
  SUPER = 'SUPER',
  SUPER_REV = 'SUPER|CTRL',
}

local function get_current_working_dir(tab)
  local current_dir = tab.active_pane and tab.active_pane.current_working_dir or { file_path = '' }
  local HOME_DIR = string.format('file://%s', os.getenv 'HOME')

  return current_dir == HOME_DIR and '.' or string.gsub(current_dir.file_path, '(.*[/\\])(.*)', '%2')
end

-- This will hold the configuration.
local config = wezterm.config_builder()
config.default_cwd = wezterm.home_dir

config.color_scheme = 'Tango (terminal.sexy)'

config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 40
config.tab_bar_at_bottom = true
config.tab_and_split_indices_are_zero_based = false

config.window_decorations = 'RESIZE'
config.window_background_opacity = 0.8
config.macos_window_background_blur = 10
config.window_padding = {
  left = 12,
  right = 8,
  top = 12,
  bottom = 8,
}

config.font = wezterm.font 'Iosevka Nerd Font Mono'
config.font_size = 15

config.inactive_pane_hsb = {
  saturation = 0.6,
  brightness = 0.6
}

config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 2000 }
config.keys = {
  { key = 'F2', mods = 'NONE', action = wezterm.action.ActivateCommandPalette },
  { key = 'F3', mods = 'NONE', action = act.ShowLauncher },
  { key = 'F4', mods = 'NONE', action = act.ShowLauncherArgs { flags = 'FUZZY|TABS' } },
  {
    key = 'F5',
    mods = 'NONE',
    action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
  },
  { key = 'F11', mods = 'NONE',        action = act.ToggleFullScreen },
  { key = 'f',   mods = mod.SUPER,     action = act.Search { CaseInSensitiveString = '' } },

  -- tabs: navigation
  { key = '[',   mods = mod.SUPER,     action = act.ActivateTabRelative(-1) },
  { key = ']',   mods = mod.SUPER,     action = act.ActivateTabRelative(1) },
  { key = '[',   mods = mod.SUPER_REV, action = act.MoveTabRelative(-1) },
  { key = ']',   mods = mod.SUPER_REV, action = act.MoveTabRelative(1) },

  -- panes --
  -- panes: split panes
  {
    key = '|',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },

  {
    key = 'c',
    mods = 'LEADER',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },

  {
    key = 'x',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'w',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false,
    },
  },
  {
    key = 'H',
    mods = 'LEADER',
    action = wezterm.action.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = 'L',
    mods = 'LEADER',
    action = wezterm.action.AdjustPaneSize { 'Right', 5 },
  },
  {
    key = 'J',
    mods = 'LEADER',
    action = wezterm.action.AdjustPaneSize { 'Down', 5 },
  },
  {
    key = 'K',
    mods = 'LEADER',
    action = wezterm.action.AdjustPaneSize { 'Up', 5 },
  },
  {
    key = 'b',
    mods = 'LEADER',
    action = wezterm.action_callback(function(win, pane)
      local tab, window = pane:move_to_new_tab()
      tab:activate()
    end),
  },

  -- Open WezTerm config file quickly
  {
    key = ',',
    mods = 'CMD',
    action = act.SpawnCommandInNewTab {
      cwd = os.getenv 'WEZTERM_CONFIG_DIR',
      set_environment_variables = {
        TERM = 'wezterm',
      },
      args = {
        '/opt/homebrew/bin/nvim',
        os.getenv 'WEZTERM_CONFIG_FILE',
      },
    },
  },

  -- Session
  { key = 's', mods = mod.SUPER, action = act { EmitEvent = 'save_session' } },
  { key = 'r', mods = mod.SUPER, action = act { EmitEvent = 'restore_session' } },
}

for i = 1, 8 do
  -- leader + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

config.key_tables = {
  resize_pane = {
    { key = 'k',      action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'j',      action = act.AdjustPaneSize { 'Down', 1 } },
    { key = 'h',      action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'l',      action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q',      action = 'PopKeyTable' },
  },
}

-- Mouse
config.mouse_bindings = {
  -- Change the default click behavior so that it only selects
  -- text and doesn't open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelection 'ClipboardAndPrimarySelection',
  },

  -- Open links on Option+Click
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'OPT',
    action = act.OpenLinkAtMouseCursor,
  },

  -- Paste on Right click
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = act.PasteFrom 'Clipboard',
  },
}

-- tmux status
wezterm.on('update-right-status', function(window, _)
  local SOLID_LEFT_ARROW = ''
  local ARROW_FOREGROUND = { Foreground = { Color = '#c6a0f6' } }
  local prefix = ''
  local name = window:active_key_table()

  if window:leader_is_active() then
    prefix = ' ' .. utf8.char(0x1f30a) -- ocean wave
    SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  end

  if window:active_tab():tab_id() ~= 0 then ARROW_FOREGROUND = { Foreground = { Color = '#1e2030' } } end -- arrow color based on if tab is first pane

  window:set_left_status(wezterm.format {
    { Background = { Color = '#b7bdf8' } },
    { Text = prefix },
    ARROW_FOREGROUND,
    { Text = SOLID_LEFT_ARROW },
  })

  if name then name = 'TABLE: ' .. name end
  window:set_right_status(wezterm.format {
    { Background = { Color = '#b7bdf8' } },
    { Text = name or '' },
    ARROW_FOREGROUND,
    { Text = SOLID_LEFT_ARROW },
  })
end)

-- Set tab title to the one that was set via `tab:set_title()`
-- or fall back to the current working directory as a title
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local index = tonumber(tab.tab_index) + 1
  local custom_title = tab.tab_title
  local title = get_current_working_dir(tab)

  if custom_title and #custom_title > 0 then title = custom_title end

  return string.format('  %s•%s  ', index, title)
end)

-- Set window title to the current working directory
wezterm.on('format-window-title', function(tab, pane, tabs, panes, config) return get_current_working_dir(tab) end)

-- Set the correct window size at the startup
wezterm.on('gui-startup', function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})

  -- Open full screen
  window:gui_window():maximize()
end)

-- Session manager
wezterm.on('save_session', function(window) session_manager.save_state(window) end)
wezterm.on('restore_session', function(window) session_manager.restore_state(window) end)

return config
