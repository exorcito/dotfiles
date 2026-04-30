#!/bin/zsh
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
OS="$(uname -s)"

echo "Instalando dotfiles en $OS desde $DOTFILES..."

# --- Homebrew ---
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ "$OS" == "Linux" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

# --- Paquetes comunes ---
brew install stow tmux neovim

# --- Ghostty (solo Mac y Linux, no WSL sin GUI) ---
if [[ "$OS" == "Darwin" ]]; then
  brew install --cask ghostty font-meslo-lg-nerd-font
elif [[ "$OS" == "Linux" ]] && [[ -z "$WSL_DISTRO_NAME" ]]; then
  brew install ghostty 2>/dev/null || echo "Ghostty no disponible, instálalo manualmente"
fi

# --- Oh My Zsh ---
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# --- PowerLevel10K ---
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
[[ ! -d "$P10K_DIR" ]] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"

# --- zsh plugins ---
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" 2>/dev/null || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" 2>/dev/null || true

# --- TPM (tmux plugins) ---
[[ ! -d "$HOME/.tmux/plugins/tpm" ]] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# --- Backup dotfiles existentes antes de stow ---
for f in .zshrc .p10k.zsh; do
  [[ -f "$HOME/$f" && ! -L "$HOME/$f" ]] && mv "$HOME/$f" "$HOME/$f.bak" && echo "Backup: $f → $f.bak"
done

# --- Stow: crear symlinks ---
cd "$DOTFILES"
stow -t ~ --restow . 2>/dev/null || stow -t ~ .

# --- Plugins tmux ---
~/.tmux/plugins/tpm/bin/install_plugins

echo ""
echo "Listo."
[[ ! -f ~/.p10k.zsh ]] && echo "Ejecuta 'p10k configure' para configurar el prompt."
