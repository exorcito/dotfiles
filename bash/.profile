# ~/.profile: ejecutado por shells de login

# Añadir binarios locales al PATH
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

# Cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Cargar .bashrc si existe y es bash
if [ -n "$BASH_VERSION" ]; then
    [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
fi
