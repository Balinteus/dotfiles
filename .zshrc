# Balinteus/dotfiles: .zshrc

# Path to oh-my-zsh installation
export ZSH="/home/$USER/.oh-my-zsh"

# Enable GPG signing
export GPG_TTY=$(tty)
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
plugins=(git zsh-autosuggestions zsh-syntax-highlighting vi-mode)

# Sourcing oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Instant autocomplete
setopt menu_complete

# Keybinds
bindkey -M viins 'jk' vi-cmd-mode

# Custom Aliases
alias py="python3"
alias pip="python3 -m pip"
alias reloadzsh="source ~/.zshrc"
alias gitr="~/.dotfiles/bin/gitea_remote_updater.sh"
alias ls="ls --group-directories-first --color=auto"
alias pmphf="~/.dotfiles/bin/pmphf.sh"
alias pyvenv="source venv/bin/activate"
alias diffdir="diff -bur"

# Custom Functions
function gpp() {
    g++ -std=c++11 -O2 -Wall $1 -o $2
}

