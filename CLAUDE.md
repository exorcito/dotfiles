# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory (`bash/`, `zsh/`, `vim/`, `nvim/`, `git/`) is a Stow package that gets symlinked into `~`.

## Installation

```bash
cd ~/dotfiles
stow -t ~ bash zsh vim git nvim
```

To install a single package:
```bash
stow -t ~ bash
```

To remove (unstow):
```bash
stow -D -t ~ bash
```

## Architecture

Each directory mirrors the target structure relative to `~`. For example:
- `bash/.bashrc` → `~/.bashrc`
- `vim/.vimrc` → `~/.vimrc`
- `nvim/.config/nvim/init.vim` → `~/.config/nvim/init.vim`

**Shell loading order:**
1. `.profile` — login shell, sets up Cargo/Rust PATH, sources `.bashrc`
2. `.bashrc` — non-login interactive shell (history, prompt, tool detection)
3. `.bash_aliases` — aliases shared across bash and zsh, loaded by both

**Tool detection pattern** used throughout `.bashrc` / `.bash_aliases`:
```bash
if command -v eza &>/dev/null; then alias ls='eza ...'; fi
```
Always follow this pattern when adding aliases for optional tools.

## Key Alias/Config Locations

| File | Purpose |
|------|---------|
| `bash/.bash_aliases` | Cross-shell aliases (eza, bat, git shortcuts, docker, etc.) |
| `zsh/.zshrc` | Oh-My-Zsh setup, plugins, zsh-specific config |
| `zsh/.p10k.zsh` | Powerlevel10k prompt (CPU, RAM, disk, uptime segments) |
| `git/.gitconfig` | Git aliases: `gs`, `ga`, `gc`, `gp`, `lg`, `pr`, `pr-clean` |
| `vim/.vimrc` | Vim with vim-plug; Go, JS/JSX support |
| `nvim/.config/nvim/init.vim` | Neovim with LSP, Telescope, Lua plugins |

## Testing Changes

There are no automated tests. To validate after editing:
```bash
source ~/.bashrc          # reload bash config
source ~/.zshrc           # reload zsh config
source ~/.p10k.zsh        # reload prompt theme
```

For Vim/Neovim changes, they take effect on next editor launch or via `:source %` inside the editor.
