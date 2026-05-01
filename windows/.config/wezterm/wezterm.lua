local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

-- Font
config.font = wezterm.font('MesloLGS NF')
config.font_size = 13.0
config.line_height = 1.0

-- Theme
config.color_scheme = 'Catppuccin Mocha'

-- Window
config.window_padding = { left = 8, right = 8, top = 8, bottom = 8 }
config.window_decorations = 'RESIZE'
config.initial_rows = 40
config.initial_cols = 180

-- Cursor
config.cursor_style = 'SteadyBar'
config.default_cursor_style = 'SteadyBar'

-- Scrollback
config.scrollback_lines = 100000

-- Performance
config.front_end = 'WebGpu'
config.max_fps = 120

-- WSL: arranca zsh con tmux (equivalente al auto-launch de Ghostty)
config.default_prog = { 'wsl.exe', '--cd', '~', '--', 'zsh', '-c', 'tmux new-session -A -s main' }

-- Tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 32
config.show_tab_index_in_tab_bar = false

-- Catppuccin Mocha tab bar manual (para que combine con el tema)
local mocha = {
  base    = '#1e1e2e',
  mantle  = '#181825',
  surface = '#313244',
  overlay = '#45475a',
  text    = '#cdd6f4',
  subtext = '#a6adc8',
  mauve   = '#cba6f7',
  blue    = '#89b4fa',
}

config.colors = {
  tab_bar = {
    background = mocha.mantle,
    active_tab = {
      bg_color  = mocha.mauve,
      fg_color  = mocha.base,
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = mocha.surface,
      fg_color = mocha.subtext,
    },
    inactive_tab_hover = {
      bg_color = mocha.overlay,
      fg_color = mocha.text,
    },
    new_tab = {
      bg_color = mocha.mantle,
      fg_color = mocha.subtext,
    },
    new_tab_hover = {
      bg_color = mocha.surface,
      fg_color = mocha.text,
    },
  },
}

-- Keybindings
-- Convención Windows en terminal: CTRL+SHIFT para acciones de la app
-- ALT+[/] y ALT+1-9 para navegar (igual que en tmux/Ghostty)
config.disable_default_key_bindings = false

config.keys = {
  -- Copy / Paste
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },

  -- Splits (como Ghostty: D horizontal, shift+D vertical)
  { key = 'd',          mods = 'CTRL|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd',          mods = 'CTRL|SHIFT|ALT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

  -- Tabs
  { key = 't', mods = 'CTRL|SHIFT', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab { confirm = false } },

  -- Navegar paneles (vim-style, como Ghostty cmd+arrows)
  { key = 'h', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Down' },

  -- Navegar tabs (Alt+[ / Alt+], igual que tmux)
  { key = '[', mods = 'ALT', action = act.ActivateTabRelative(-1) },
  { key = ']', mods = 'ALT', action = act.ActivateTabRelative(1) },

  -- Tabs por número (Alt+1-9, igual que tmux)
  { key = '1', mods = 'ALT', action = act.ActivateTab(0) },
  { key = '2', mods = 'ALT', action = act.ActivateTab(1) },
  { key = '3', mods = 'ALT', action = act.ActivateTab(2) },
  { key = '4', mods = 'ALT', action = act.ActivateTab(3) },
  { key = '5', mods = 'ALT', action = act.ActivateTab(4) },
  { key = '6', mods = 'ALT', action = act.ActivateTab(5) },
  { key = '7', mods = 'ALT', action = act.ActivateTab(6) },
  { key = '8', mods = 'ALT', action = act.ActivateTab(7) },
  { key = '9', mods = 'ALT', action = act.ActivateTab(8) },

  -- Fullscreen
  { key = 'Enter', mods = 'CTRL|SHIFT', action = act.ToggleFullScreen },

  -- Zoom pane
  { key = 'z', mods = 'CTRL|SHIFT', action = act.TogglePaneZoomState },

  -- Recargar config
  { key = 'r', mods = 'CTRL|SHIFT', action = act.ReloadConfiguration },

  -- Aumentar / reducir fuente
  { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = act.ResetFontSize },
}

return config
