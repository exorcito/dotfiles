# dotfiles

My personal dotfiles for macOS, Windows/WSL and LXC, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Stack

| Tool | Role |
|---|---|
| [Ghostty](https://ghostty.org) | Terminal emulator (macOS) |
| [WezTerm](https://wezfurlong.org/wezterm/) | Terminal emulator (Windows/WSL) |
| [tmux](https://github.com/tmux/tmux) | Terminal multiplexer |
| [sesh](https://github.com/joshmedeski/sesh) | tmux session manager |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smart directory jumper |
| [Neovim](https://neovim.io) + [LazyVim](https://lazyvim.org) | Editor |
| [Oh My Zsh](https://ohmyz.sh) + [PowerLevel10k](https://github.com/romkatv/powerlevel10k) | Shell (macOS / WSL) |
| [Catppuccin Mocha](https://github.com/catppuccin/catppuccin) | Theme (all terminals + Neovim) |

## Structure

```
.
├── .config/
│   ├── ghostty/         # Ghostty config (macOS)
│   ├── tmux/            # tmux + sesh keybindings
│   └── nvim/            # Neovim / LazyVim
├── .zshrc               # macOS shell: Oh My Zsh + PowerLevel10k + zoxide
├── .p10k.zsh            # PowerLevel10k config
├── lxc/                 # LXC stow package: .zshrc (robbyrussell) + .gitconfig
├── windows/
│   └── .config/wezterm/ # WezTerm config (Windows/WSL)
├── bash/                # Shared: .bashrc, .profile, .bash_aliases
├── vim/                 # .vimrc (macOS + LXC)
├── git/                 # .gitconfig with osxkeychain (macOS)
└── scripts/
    └── lxc-bootstrap.sh
```

## Install (macOS)

```sh
git clone https://github.com/exorcito/dotfiles ~/dotfiles
~/dotfiles/install.sh
```

The script installs all dependencies and runs `stow .` to symlink everything into `~`.

### Manual steps after install

1. Open Ghostty — tmux starts automatically
2. Run `p10k configure` to set up the shell prompt
3. Open `nvim` — LazyVim installs plugins on first launch

### Stow manually

```sh
cd ~/dotfiles && stow -t ~ .
```

## Install (Windows / WSL)

1. Install [WezTerm](https://wezfurlong.org/wezterm/installation.html) on Windows
2. Clone the repo inside WSL and link the WezTerm config from Windows:

```powershell
# PowerShell (as Administrator)
git clone https://github.com/exorcito/dotfiles $env:USERPROFILE\dotfiles
New-Item -ItemType Directory -Force "$env:USERPROFILE\.config\wezterm"
New-Item -ItemType SymbolicLink `
  -Path "$env:USERPROFILE\.config\wezterm\wezterm.lua" `
  -Target "$env:USERPROFILE\dotfiles\windows\.config\wezterm\wezterm.lua"
```

3. Bootstrap the WSL environment (same as LXC):

```sh
curl -fsSL https://raw.githubusercontent.com/exorcito/dotfiles/main/scripts/lxc-bootstrap.sh | bash
```

WezTerm launches WSL and auto-attaches to a tmux session named `main`.

## Install (LXC / Linux)

```sh
curl -fsSL https://raw.githubusercontent.com/exorcito/dotfiles/main/scripts/lxc-bootstrap.sh | bash
```

Installs: zsh, oh-my-zsh, plugins, eza, bat, toilet, fzf, then stows `bash lxc vim`.

Or manually:

```sh
git clone https://github.com/exorcito/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow -t ~ bash lxc vim
```

## Keybindings

### macOS — tmux via Ghostty

| Action | Shortcut |
|---|---|
| New window | `Cmd+T` |
| Close pane | `Cmd+W` |
| Split right | `Cmd+D` |
| Split down | `Cmd+Shift+D` |
| Navigate panes | `Cmd+↑↓←→` |
| Next / prev window | `Cmd+]` / `Cmd+[` |
| Go to window N | `Cmd+1…9` |
| Session picker (sesh) | `Ctrl+A T` |
| Zoom pane | `Ctrl+A Z` |
| Rename window | `Ctrl+A ,` |
| Fullscreen | `Cmd+Shift+Enter` |
| Reload tmux config | `Ctrl+A R` |

### Windows — WezTerm

| Action | Shortcut |
|---|---|
| Copy | `Ctrl+Shift+C` |
| Paste | `Ctrl+Shift+V` |
| New tab | `Ctrl+Shift+T` |
| Close tab | `Ctrl+Shift+W` |
| Split right | `Ctrl+Shift+D` |
| Split down | `Ctrl+Shift+Alt+D` |
| Navigate panes | `Ctrl+Shift+H/J/K/L` |
| Next / prev tab | `Alt+]` / `Alt+[` |
| Go to tab N | `Alt+1…9` |
| Fullscreen | `Ctrl+Shift+Enter` |
| Zoom pane | `Ctrl+Shift+Z` |
| Reload config | `Ctrl+Shift+R` |

## OS support

| | macOS | WSL | LXC |
|---|:---:|:---:|:---:|
| zsh + P10K | ✅ | ✅ | ❌ |
| zsh + robbyrussell | ✅ | ✅ | ✅ |
| tmux | ✅ | ✅ | ⚠️ |
| Neovim | ✅ | ✅ | ⚠️ |
| Ghostty | ✅ | ❌ | ❌ |
| WezTerm | ✅ | ✅ | ❌ |
| sesh | ✅ | ✅ | ❌ |
| zoxide | ✅ | ✅ | ✅ |
