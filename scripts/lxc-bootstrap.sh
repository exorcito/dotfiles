#!/usr/bin/env bash
# Bootstrap dotfiles on a fresh Debian/Ubuntu LXC
set -euo pipefail

DOTFILES_REPO="https://github.com/exorcito/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

apt-get update -qq
apt-get install -y -qq git stow zsh toilet figlet fzf curl

# eza (modern ls)
if ! command -v eza &>/dev/null; then
    curl -fsSL https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-musl.tar.gz \
        | tar xz -C /usr/local/bin eza
fi

# bat (modern cat)
if ! command -v bat &>/dev/null; then
    BAT_VER=$(curl -s https://api.github.com/repos/sharkdp/bat/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
    curl -fsSL "https://github.com/sharkdp/bat/releases/latest/download/bat_${BAT_VER#v}_amd64.deb" -o /tmp/bat.deb
    dpkg -i /tmp/bat.deb && rm /tmp/bat.deb
fi

# oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && \
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && \
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-history-substring-search" ] && \
    git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search "$ZSH_CUSTOM/plugins/zsh-history-substring-search"

# dotfiles
if [ ! -d "$DOTFILES_DIR" ]; then
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

# Remove existing files that stow would conflict with
for f in .zshrc .gitconfig .bash_aliases .bashrc .vimrc .profile; do
    [ -f "$HOME/$f" ] && [ ! -L "$HOME/$f" ] && mv "$HOME/$f" "$HOME/$f.bak"
done

stow -t "$HOME" bash lxc vim

# Set zsh as default shell
chsh -s "$(command -v zsh)" root

echo "Done. Re-login to start zsh."
