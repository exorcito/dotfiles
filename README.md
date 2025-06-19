# Dotfiles 

Este repositorio contiene mis configuraciones personales para bash, zsh, tmux, vim/neovim, git, y más. Está optimizado para funcionar en Linux, macOS, WSL, LXC y otros entornos.

## Estructura recomendada para GNU Stow

Cada grupo de dotfiles está en su propia carpeta:

```
.
├── bash/
│   ├── .bashrc
│   ├── .profile
│   └── .bash_aliases
├── zsh/
│   ├── .zshrc
│   └── .p10k.zsh
├── tmux/
│   └── .tmux.conf
├── vim/
│   └── .vimrc
├── nvim/
│   └── init.vim (o configuración Lua)
├── git/
│   └── .gitconfig
└── README.md
```

## Instalación con Stow

1. Instala Stow:
   - Debian/Ubuntu: `sudo apt install stow`
   - macOS: `brew install stow`
   - Arch: `sudo pacman -S stow`

2. Clona este repositorio en tu home:
   ```sh
   git clone https://github.com/tuusuario/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

3. Aplica los dotfiles que quieras. Por ejemplo:
   ```sh
   stow -t ~ bash zsh tmux vim git
   ```
   Esto creará enlaces simbólicos en tu $HOME para cada archivo de configuración.

4. Si usas Neovim:
   ```sh
   stow -t ~ nvim
   ```

5. Personaliza los archivos locales si lo necesitas antes de aplicar Stow.

## Notas
- Puedes añadir o quitar carpetas según tus necesidades.
- Los dotfiles detectan automáticamente herramientas modernas si están instaladas.
- Para personalizaciones privadas, usa archivos locales (por ejemplo, `.tmux.conf.local`).

---

**¡Disfruta de tu entorno shell optimizado y multiplataforma!** 