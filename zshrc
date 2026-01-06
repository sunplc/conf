# color term like 'ls'
export CLICOLOR='Yes'
# custom shell prompt
autoload -U colors && colors
PROMPT="%{$fg[green]%}%n@%m%{$reset_color%} %{$fg[blue]%}%1~%{$reset_color%} %# "

# self defined aliases
alias ll='ls -l'
alias la='ls -a'
