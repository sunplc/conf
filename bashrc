# .bashrc file

PS1='\[\033[01;32m\][\u@\h \W]$\[\033[00;37m\] '

alias ll='ls -altrh --time-style=long-iso'
alias date='date +%Y-%m-%d__%H:%M:%S'
alias tmux='tmux -2 new -s coding'

# Alias for git

###  设置 git diff 使用 vimdiff ###
# git config --global diff.tool vimdiff
# git config --global difftool.prompt false
# git config --global alias.d difftool
#
# git config --global difftool.trustExitCode true
# git config --global mergetool.trustExitCode true
###################################

alias gb='git branch'
alias gs='git status'
alias ga='git add'
alias gl='git log'
alias gc='git commit -m'
alias gck='git checkout'
alias gp='git push'
alias gpl='git pull'
alias gd='git d'
alias gco='git checkout'
