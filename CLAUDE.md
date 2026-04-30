# CLAUDE.md

This file provides guidance to Claude Code when working with this repository.

## What This Repo Is

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/), supporting macOS and LXC/Linux environments with separate configs where needed.

## Structure

```
dotfiles/
  .config/            # ~/.config/* (Mac: Ghostty, tmux, Neovim/LazyVim)
  .zshrc              # Mac zsh config (Oh My Zsh + PowerLevel10k)
  .p10k.zsh           # PowerLevel10k prompt config
  lxc/                # LXC-specific stow package
    .zshrc            # Lightweight zsh (robbyrussell, no P10K)
    .gitconfig        # Git without osxkeychain
  bash/               # Shared bash config (Mac + LXC)
  vim/                # .vimrc (Mac + LXC)
  git/                # .gitconfig with osxkeychain (Mac only)
  scripts/
    lxc-bootstrap.sh  # One-liner bootstrap for Debian/Ubuntu LXC
  install.sh          # Mac bootstrap script
```

## Stow Usage

**Mac** — stow the flat root (`.zshrc`, `.p10k.zsh`, `.config/`):
```bash
cd ~/dotfiles && stow -t ~ .
```

**LXC / Linux** — stow specific packages:
```bash
cd ~/dotfiles && stow -t ~ bash lxc vim
```

`.stow-local-ignore` prevents `lxc/`, `bash/`, `vim/`, `git/`, `scripts/` from being picked up by `stow .` on Mac.

## Key Files

| File | Purpose |
|------|---------|
| `.zshrc` | Mac shell: Oh My Zsh, P10K, Ghostty auto-start tmux |
| `.config/ghostty/config` | Ghostty: Catppuccin Mocha, keybindings delegated to tmux |
| `.config/tmux/tmux.conf` | tmux: Ctrl+A prefix, Catppuccin v2, resurrect/continuum |
| `.config/nvim/` | Neovim: LazyVim + Catppuccin Mocha |
| `lxc/.zshrc` | LXC shell: Oh My Zsh, robbyrussell, banner with toilet |
| `bash/.bash_aliases` | Cross-shell aliases (eza, bat, git, docker) |

## Testing Changes

```bash
source ~/.zshrc        # reload zsh
tmux source ~/.config/tmux/tmux.conf  # reload tmux (or Ctrl+A R)
```

Neovim changes take effect on next launch or `:Lazy sync` inside nvim.
