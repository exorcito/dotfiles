# Login banner
_vcpu=$(nproc)
_ram=$(free -h | awk '/Mem:/ {print $3 " / " $2}')
_disk=$(df -h / | awk 'NR==2 {print $3 " / " $2}')
_uptime=$(uptime -p | sed 's/up //')
_ip=$(hostname -I | awk '{print $1}')
/bin/toilet -f future --filter gay "$(hostname)"
echo "🖥️  vCPU: $_vcpu cores | RAM: $_ram | Disco: $_disk | Uptime: $_uptime | IP: $_ip"
echo ""

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode auto

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

plugins=(
    command-not-found
    docker
    git
    gitignore
    fzf
    history-substring-search
    sudo
    z
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Historial
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=4000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

# Editor
export EDITOR="vim"
export LESS='-R'

# Aliases
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons'
    alias ll='eza -l --icons'
    alias la='eza -a --icons'
    alias l='eza -1 --icons'
else
    alias ls='ls --color=auto'
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
fi

if command -v bat >/dev/null 2>&1; then
    alias cat='bat'
fi

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'

# PATH
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Autocompletado
autoload -Uz compinit && compinit
