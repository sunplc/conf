# .bashrc file

PS1='\[\033[01;32m\][\u@\h \W]$\[\033[00;37m\] '

alias ll='ls -altrh --time-style=long-iso'
alias date='date +%Y-%m-%d__%H:%M:%S'
alias tmux='tmux -2 new -s coding'

# Alias for git
alias gb='git branch'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gd='git diff'
alias gco='git checkout'

# cd and ls a dir
function cl() {
	cd "$@" && ls
}
