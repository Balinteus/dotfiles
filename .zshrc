# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/$USER/.oh-my-zsh"

# NVM Setup
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Enable GPG signing
export GPG_TTY=$(tty)

if [ ! -f ~/.gnupg/S.gpg-agent ]; then
    eval $( gpg-agent --daemon --options ~/.gnupg/gpg-agent.conf )
fi

export GPG_AGENT_INFO=${HOME}/.gnupg/S.gpg-agent:0:1

# Colored MAN pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Theme
ZSH_THEME="cleanified"

# Plugins
plugins=(git python zsh-autosuggestions zsh-syntax-highlighting vi-mode npm)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Instant autocomplete
setopt menu_complete

# Keybinds
bindkey -M viins 'jk' vi-cmd-mode

# Custom Aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh"
alias py="python3"
alias pip="python3 -m pip"
alias reloadzsh="source ~/.zshrc"

# Custom Functions
function gpp() {
    g++ -std=c++11 -O2 -Wall $1 -o $2
}

#prompt_context(){}

