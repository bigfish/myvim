
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# enable color support of ls and also add handy aliases
# if [ -x /usr/bin/dircolors ]; then
#     test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#     alias ls='ls --color=auto'
#     alias grep='grep --color=auto'
#     alias fgrep='fgrep --color=auto'
#     alias egrep='egrep --color=auto'
# fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.vim/.bash_aliases ]; then
    . ~/.vim/.bash_aliases
fi

#.bash_profile
#[ -d "/usr/local/opt/python@2/bin" ] && export PATH="/usr/local/opt/python@2/bin:$PATH"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    #. /etc/bash_completion
#fi

#[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh


export EDITOR=vim
export PAGER=less

#prevent flow control
stty -ixon
stty stop ''
stty start ''

#export LC_CTYPE=en_US.UTF-8
#export LC_ALL=en_US.UTF-8
#LESS COLORS
#moved to .bash_profile...
#export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS=" -R "
#CONFIGURE PATH
#export PATH=$NODE_PATH/bin:$HOME/bin:$PATH
#export LESS=' -R '

#export CPPFLAGS=-I/usr/local/opt/openssl/include
#export LDFLAGS=-L/usr/local/opt/openssl/lib

. ~/bin/git-completion.bash

#parse_git_branch() {
    #git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
#}
. ~/bin/git-prompt.sh
set t_Co=256

#if [ -f $(brew --prefix)/etc/bash_completion ]; then
    #. $(brew --prefix)/etc/bash_completion
#fi
if [ "$(uname)" == "Darwin" ]; then
eval "$(/opt/homebrew/bin/brew shellenv)"
fi

set -o emacs

go()
{
if [ -f "$1" ]
then
    $EDITOR "$1"
else
    cd "$1" && ls
fi
}

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
eval "$(fzf --bash)"

#eval $(gdircolors ~/.dircolors/dircolors.ansi-dark)

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export BASH_SILENCE_DEPRECATION_WARNING=1
#export GIT_PS1_SHOWDIRTYSTATE=1
#export PS1='\w$(__git_ps1 " (%s)") \[\e[0;32m\]>:\[\e[m\] '

#export PS1="\\[$(tput setaf 7)\\]\[\e[0;33m\]\\w\[\e[0;33m\]\[\e[m\]\[\e[0;32m\]\$(parse_git_branch)\[\e[0;32m\]\[\e[m\]\[\e[1;32m\] >: \[\e[1;32m\]\\[$(tput sgr0)\\]"
#export PS1="\\[$(tput setaf 7)\\]\[\e[0;33m\]\\w\[\e[0;33m\]\[\e[m\]\[\e[0;32m\]\$()\[\e[0;32m\]\[\e[m\]\[\e[1;32m\] >: \[\e[1;32m\]\\[$(tput sgr0)\\]"
#PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
# changing PROMPT_COMMAND breaks autojump :/
#export PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
#PROMPT_COMMAND='__git_ps1 "\\[$(tput setaf 7)\\]\[\e[0;33m\]\\w\[\e[0;33m\]\[\e[m\]\[\e[0;32m\]" "\[\e[0;32m\]\[\e[m\]\[\e[1;32m\] >: \[\e[1;32m\]\\[$(tput sgr0)\\]"'
MY_PROMPT_COMMAND='__git_ps1 "\\[$(tput setaf 7)\\]\[\e[0;33m\]\\w\[\e[0;33m\]\[\e[m\]\[\e[0;32m\]" "\[\e[0;32m\]\[\e[m\]\[\e[1;32m\] >: \[\e[1;32m\]\\[$(tput sgr0)\\]"'

# workaround gotcha with autojump
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} $MY_PROMPT_COMMAND"


#moved to .bash_profile...
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export GTAGSLABEL=ctags
export GTAGSCONF=/usr/local/share/gtags/gtags.conf
export GTAGSLABEL=new-ctags

[ -f ~/fzf.sh ] && source ~/fzf.sh

#export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

. ~/.bash_env

alias pnx="pnpm nx"

# pnpm
export PNPM_HOME="/Users/DavidWilhelm/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

#alias docker_clean_images="docker rmi $(docker images -a --filter=dangling=true -q)"
#alias docker_clean_ps="docker rm $(docker ps --filter=status=exited --filter=status=created -q)"
