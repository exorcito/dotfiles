# Alias multiplataforma y condicionales para comandos modernos

# Sudo siempre con -E
alias s='sudo -E'
alias sudo='sudo -E'

# Vim alternativo si existe vimx
if command -v vimx >/dev/null 2>&1; then
    alias vim='vimx'
fi

# Alias para ls, eza y bat según disponibilidad
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

# Color para grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Función extract universal
extract () {
    if [ -f "$1" ] ; then
      case "$1" in
        *.tar.bz2)   tar xjf "$1"     ;;
        *.tar.gz)    tar xzf "$1"     ;;
        *.bz2)       bunzip2 "$1"     ;;
        *.rar)       unrar e "$1"     ;;
        *.gz)        gunzip "$1"      ;;
        *.tar)       tar xf "$1"      ;;
        *.tbz2)      tar xjf "$1"     ;;
        *.tgz)       tar xzf "$1"     ;;
        *.zip)       unzip "$1"       ;;
        *.Z)         uncompress "$1"  ;;
        *.7z)        7z x "$1"        ;;
        *)     echo "'$1' no se puede extraer con extract()" ;;
         esac
     else
         echo "'$1' no es un archivo válido"
     fi
}

# Top 10 procesos por CPU
alias top10="ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Leer CSV bonito
read_csv(){
    sed 's/,,/, ,/g;s/,,/, ,/g' "$1" | column -s, -t
}

# Docker: limpiar contenedores salidos
if command -v docker >/dev/null 2>&1; then
    alias do_cleanup_exited="docker rm $(docker ps -a --filter='status=exited' -q)"
fi

# Alias para Windows (WSL) y Linux
if grep -qi microsoft /proc/version 2>/dev/null; then
    alias explorer='explorer.exe'
fi

# Alias git útiles si no están en .gitconfig
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
