export BASH_SILENCE_DEPRECATION_WARNING=1
#export GIT_PS1_SHOWDIRTYSTATE=1
#export PS1='\w$(__git_ps1 " (%s)") \[\e[0;32m\]>:\[\e[m\] '

#export PS1="\\[$(tput setaf 7)\\]\[\e[0;33m\]\\w\[\e[0;33m\]\[\e[m\]\[\e[0;32m\]\$(parse_git_branch)\[\e[0;32m\]\[\e[m\]\[\e[1;32m\] >: \[\e[1;32m\]\\[$(tput sgr0)\\]"
#export PS1="\\[$(tput setaf 7)\\]\[\e[0;33m\]\\w\[\e[0;33m\]\[\e[m\]\[\e[0;32m\]\$()\[\e[0;32m\]\[\e[m\]\[\e[1;32m\] >: \[\e[1;32m\]\\[$(tput sgr0)\\]"
#PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
# changing PROMPT_COMMAND breaks autojump :/
#export PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
#PROMPT_COMMAND='__git_ps1 "\\[$(tput setaf 7)\\]\[\e[0;33m\]\\w\[\e[0;33m\]\[\e[m\]\[\e[0;32m\]" "\[\e[0;32m\]\[\e[m\]\[\e[1;32m\] >: \[\e[1;32m\]\\[$(tput sgr0)\\]"'
PROMPT_COMMAND='__git_ps1 "\\[$(tput setaf 7)\\]\[\e[0;33m\]\\w\[\e[0;33m\]\[\e[m\]\[\e[0;32m\]" "\[\e[0;32m\]\[\e[m\]\[\e[1;32m\] >: \[\e[1;32m\]\\[$(tput sgr0)\\]"'
#moved to .bash_profile...
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS="--layout=reverse --height=50% --bind 'f1:execute(bat {}),ctrl-y:execute-silent(echo {} | pbcopy)+abort'"
export FZF_TMUX=1
export GTAGSLABEL=ctags
. ./.bashrc
