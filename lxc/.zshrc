# Login banner
_vcpu=$(nproc)
_ram=$(free -h | awk '/Mem:/ {print $3 " / " $2}')
_disk=$(df -h / | awk 'NR==2 {print $3 " / " $2}')
_uptime=$(uptime -p | sed 's/up //')
_ip=$(hostname -I | awk '{print $1}')
/bin/toilet -f future --filter gay "$(hostname)"
echo "🖥️  vCPU: $_vcpu cores | RAM: $_ram | Disco: $_disk | Uptime: $_uptime | IP: $_ip"
echo ""

export ZSH="$HOME/.oh-my-zsh"

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

HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=4000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

export EDITOR="vim"
export LESS='-R'

[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

autoload -Uz compinit && compinit
