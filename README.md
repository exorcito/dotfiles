# dotfiles

My personal dotfiles for macOS, Linux, WSL and LXC, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Stack

| Tool | Role |
|---|---|
| [Ghostty](https://ghostty.org) | Terminal emulator |
| [tmux](https://github.com/tmux/tmux) | Terminal multiplexer |
| [Neovim](https://neovim.io) + [LazyVim](https://lazyvim.org) | Editor |
| [Oh My Zsh](https://ohmyz.sh) + [PowerLevel10k](https://github.com/romkatv/powerlevel10k) | Shell |
| [Catppuccin Mocha](https://github.com/catppuccin/catppuccin) | Theme (Ghostty + tmux + Neovim) |

## Structure

```
.
├── bash/            # .bashrc, .profile, .bash_aliases (Mac + LXC)
├── zsh/             # .zshrc + .p10k.zsh with Powerlevel10k (Mac)
├── lxc/             # .zshrc without p10k, .gitconfig without osxkeychain (LXC/homelab)
├── vim/             # .vimrc (Mac + LXC)
├── nvim/            # init.vim with LSP and Telescope (Mac)
├── git/             # .gitconfig with osxkeychain (Mac)
└── scripts/
    └── lxc-bootstrap.sh  # automated bootstrap for fresh Debian/Ubuntu LXC
```

## Install (Mac)

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
cd ~/dotfiles && stow -t ~ bash zsh vim nvim git
```

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

## Keybindings (tmux via Ghostty)

| Action | Shortcut |
|---|---|
| New window | `Cmd+T` |
| Close pane | `Cmd+W` |
| Split right | `Cmd+D` |
| Split down | `Cmd+Shift+D` |
| Navigate panes | `Cmd+↑↓←→` |
| Next / prev window | `Cmd+]` / `Cmd+[` |
| Go to window N | `Cmd+1…9` |
| Zoom pane | `Ctrl+A Z` |
| Rename window | `Ctrl+A ,` |
| Reload tmux config | `Ctrl+A R` |

## OS support

| | macOS | Linux | WSL | LXC |
|---|:---:|:---:|:---:|:---:|
| zsh + P10K | ✅ | ✅ | ✅ | ❌ |
| zsh + robbyrussell | ✅ | ✅ | ✅ | ✅ |
| tmux | ✅ | ✅ | ✅ | ⚠️ |
| Neovim | ✅ | ✅ | ✅ | ⚠️ |
| Ghostty | ✅ | ✅ | ⚠️ | ❌ |
