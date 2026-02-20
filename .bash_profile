source ~/.profile
. ~/.bashrc
#export PATH="/usr/local/opt/icu4c/bin:$PATH"

if [ "$(uname)" == "Darwin" ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi
