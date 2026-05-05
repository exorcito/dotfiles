local wezterm = require 'wezterm'
local config  = wezterm.config_builder()
local act     = wezterm.action

-- ── Font ────────────────────────────────────────────────────────────────────
config.font      = wezterm.font('MesloLGS NF')
config.font_size = 13.0

-- ── Theme ───────────────────────────────────────────────────────────────────
config.color_scheme = 'Catppuccin Mocha'

-- ── Window ──────────────────────────────────────────────────────────────────
config.window_padding     = { left = 8, right = 8, top = 8, bottom = 8 }
config.window_decorations = 'RESIZE'
config.initial_rows       = 40
config.initial_cols       = 180

-- ── Cursor ──────────────────────────────────────────────────────────────────
config.default_cursor_style = 'SteadyBar'

-- ── Scrollback & perf ───────────────────────────────────────────────────────
config.scrollback_lines = 100000
config.front_end        = 'WebGpu'
config.max_fps          = 120

-- ── WSL: arranca zsh + tmux igual que Ghostty en Mac ───────────────────────
config.default_prog = { 'wsl.exe', '--cd', '~', '--', 'zsh', '-c', 'tmux new-session -A -s main' }

-- ── Tab bar (Catppuccin Mocha manual) ───────────────────────────────────────
config.use_fancy_tab_bar         = false
config.tab_bar_at_bottom         = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width             = 32

local mocha = {
  base    = '#1e1e2e',
  mantle  = '#181825',
  surface = '#313244',
  overlay = '#45475a',
  text    = '#cdd6f4',
  subtext = '#a6adc8',
  mauve   = '#cba6f7',
}

config.colors = {
  tab_bar = {
    background        = mocha.mantle,
    active_tab        = { bg_color = mocha.mauve,   fg_color = mocha.base,    intensity = 'Bold' },
    inactive_tab      = { bg_color = mocha.surface, fg_color = mocha.subtext },
    inactive_tab_hover= { bg_color = mocha.overlay, fg_color = mocha.text },
    new_tab           = { bg_color = mocha.mantle,  fg_color = mocha.subtext },
    new_tab_hover     = { bg_color = mocha.surface, fg_color = mocha.text },
  },
}

-- ── Keybindings ─────────────────────────────────────────────────────────────
-- Misma filosofía que Ghostty: todo delegado a tmux vía secuencias \x01 (Ctrl+A).
-- Equivalencias:  Cmd+X (Mac)  →  Ctrl+Shift+X (Windows)
-- Los atajos Alt+[/] y Alt+1-9 los maneja tmux directamente (bind -n M-...).

config.disable_default_key_bindings = true

config.keys = {
  -- Copy / Paste (lo único que gestiona WezTerm, no tmux)
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },

  -- Splits → tmux  (= Cmd+D / Cmd+Shift+D en Mac)
  { key = 'd', mods = 'CTRL|SHIFT',       action = act.SendString('\x01|') },
  { key = 'd', mods = 'CTRL|SHIFT|ALT',   action = act.SendString('\x01-') },

  -- Nueva ventana tmux / cerrar pane  (= Cmd+T / Cmd+W en Mac)
  { key = 't', mods = 'CTRL|SHIFT',       action = act.SendString('\x01c') },
  { key = 'w', mods = 'CTRL|SHIFT',       action = act.SendString('\x01x') },

  -- Navegar paneles vim-style  (= Cmd+Flechas en Mac)
  { key = 'LeftArrow',  mods = 'CTRL|SHIFT', action = act.SendString('\x01h') },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = act.SendString('\x01l') },
  { key = 'UpArrow',    mods = 'CTRL|SHIFT', action = act.SendString('\x01k') },
  { key = 'DownArrow',  mods = 'CTRL|SHIFT', action = act.SendString('\x01j') },

  -- Ventanas por número  (Alt+1-9 ya funciona vía tmux bind -n M-1..9)
  -- Las dejamos aquí también por si tmux no está activo
  { key = '1', mods = 'ALT', action = act.SendString('\x011') },
  { key = '2', mods = 'ALT', action = act.SendString('\x012') },
  { key = '3', mods = 'ALT', action = act.SendString('\x013') },
  { key = '4', mods = 'ALT', action = act.SendString('\x014') },
  { key = '5', mods = 'ALT', action = act.SendString('\x015') },
  { key = '6', mods = 'ALT', action = act.SendString('\x016') },
  { key = '7', mods = 'ALT', action = act.SendString('\x017') },
  { key = '8', mods = 'ALT', action = act.SendString('\x018') },
  { key = '9', mods = 'ALT', action = act.SendString('\x019') },

  -- Prev / next ventana  (Alt+[ / Alt+])
  { key = '[', mods = 'ALT', action = act.SendString('\x01p') },
  { key = ']', mods = 'ALT', action = act.SendString('\x01n') },

  -- WezTerm nativo: fullscreen, zoom pane, fuente, reload
  { key = 'Enter', mods = 'CTRL|SHIFT',    action = act.ToggleFullScreen },
  { key = 'z',     mods = 'CTRL|SHIFT',    action = act.SendString('\x01z') },
  { key = '+',     mods = 'CTRL',          action = act.IncreaseFontSize },
  { key = '-',     mods = 'CTRL',          action = act.DecreaseFontSize },
  { key = '0',     mods = 'CTRL',          action = act.ResetFontSize },
  { key = 'r',     mods = 'CTRL|SHIFT',    action = act.ReloadConfiguration },
}

return config
