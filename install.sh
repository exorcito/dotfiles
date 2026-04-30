#!/bin/zsh
# Instala dotfiles con stow. Ejecutar desde ~/dotfiles.
set -e

DOTFILES="$HOME/dotfiles"

echo "Instalando dotfiles desde $DOTFILES..."

# Dependencias
if ! command -v brew &>/dev/null; then
  echo "Instalando Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew install stow tmux
brew install --cask ghostty font-meslo-lg-nerd-font

# Oh My Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# PowerLevel10K
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

# zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" 2>/dev/null || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" 2>/dev/null || true

# TPM para tmux
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Neovim
brew install neovim

# Stow — crear symlinks
cd "$DOTFILES"
for pkg in zsh ghostty tmux nvim; do
  stow -t ~ --restow "$pkg" 2>/dev/null || stow -t ~ "$pkg"
done

# Plugins de tmux
~/.tmux/plugins/tpm/bin/install_plugins

echo ""
echo "Listo. Abre Ghostty y ejecuta 'p10k configure' si es la primera vez."
