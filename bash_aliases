alias s='sudo -E'
alias sudo='sudo -E'

if [[ $(command -v vimx) ]]; then
    alias vim='vimx'
fi

#Color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#File Work

extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}


alias top10="ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

#TMUX
alias tcr="for i in \$(tmux list-windows | awk -v x=\$(tmux display-message -p '#I') -F ':' '\$1 > x {print \$1}'); do tmux kill-window -t \$i ; done"


function read_csv(){
    sed 's/,,/, ,/g;s/,,/, ,/g' $1 | column -s, -t
}


#Docker commands
alias do_cleanup_exited="docker rm $(docker ps -a --filter='status=exited' -q)"
