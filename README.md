# dotfiles

My personal dotfiles for macOS, Linux and WSL, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Stack

| Tool | Role |
|---|---|
| [Ghostty](https://ghostty.org) | Terminal emulator |
| [tmux](https://github.com/tmux/tmux) | Terminal multiplexer |
| [Neovim](https://neovim.io) + [LazyVim](https://lazyvim.org) | Editor |
| [Oh My Zsh](https://ohmyz.sh) + [PowerLevel10k](https://github.com/romkatv/powerlevel10k) | Shell |
| [Catppuccin Mocha](https://github.com/catppuccin/catppuccin) | Theme (Ghostty + tmux + Neovim) |

## Install

```sh
git clone https://github.com/exorcito/dotfiles ~/dotfiles
~/dotfiles/install.sh
```

The script installs all dependencies and runs `stow .` to symlink everything into `~`.

## Manual steps after install

1. Open Ghostty — tmux starts automatically
2. Run `p10k configure` to set up the shell prompt
3. Open `nvim` — LazyVim installs plugins on first launch

## Stow

To re-apply symlinks manually:

```sh
cd ~/dotfiles && stow -t ~ .
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

| | macOS | Linux | WSL |
|---|:---:|:---:|:---:|
| zsh + P10K | ✅ | ✅ | ✅ |
| tmux | ✅ | ✅ | ✅ |
| Neovim | ✅ | ✅ | ✅ |
| Ghostty | ✅ | ✅ | ⚠️ |
