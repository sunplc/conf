# ~/.bashrc file

PS1='\[\033[01;32m\][\u@\h \W]$\[\033[00;37m\] '

alias ll='ls -altrh --time-style=long-iso'
alias date='date +%Y-%m-%d__%H:%M:%S__%A_%B'
alias tmux='tmux -2 new -s coding'

# cd and ls a dir
function cl() {
	cd "$@" && ls
}
