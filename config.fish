set -x EDITOR '/usr/bin/vim'
set SPACEFISH_PROMPT_SEPARATE_LINE false
set fish_greeting
set SPACEFISH_PROMPT_ORDER host time user dir git package jobs char
set SPACEFISH_DIR_TRUNC 10
#set SPACEFISH_DIR_PREFIX
set SPACEFISH_GIT_PREFIX
set SPACEFISH_PACKAGE_PREFIX
set SPACEFISH_CHAR_SYMBOL ':<'
bind \t forward-char

set -x NVM_DIR "$HOME/.nvm"

function nvm
   bass source $NVM_DIR/nvm.sh --no-use ';' nvm $argv
end

nvm use default --silent
