# Print out the system MOTD
cat /etc/motd

# Theme
ZSH_THEME="cleanified"

# Plugins
plugins=(zsh-autosuggestions zsh-syntax-highlighting vi-mode)

# Autoloads
autoload -U colors && colors
autoload -U compaudit compinit zrecompile

# Source the plugin & lib loader script
source $ZDOTDIR/init.zsh

# Setup autocompletion
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list \
	'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' 'r:|=*' 'l:|=* r:|=*'
[[ -z "$LS_COLORS" ]] || zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
compinit -d $ZSH_COMPDUMP

# Shell options
setopt interactivecomments
setopt prompt_subst
setopt auto_menu
setopt menu_complete
setopt always_to_end
setopt complete_in_word
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_expire_dups_first
setopt sharehistory
unsetopt flowcontrol

# Keybinds
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^n' expand-or-complete
bindkey '^h' backward-kill-word

# Custom Aliases
alias vim="nvim"
alias py="python3"
alias pip="python3 -m pip"
alias pyvenv="source venv/bin/activate"
alias ls="ls --group-directories-first --color=auto"
alias ll="ls -lh"
alias la="ls -lAh"
alias tree="tree --dirsfirst"
alias info="info --vi-keys"
alias diffdir="diff -bur"
alias ao="alacritty msg config -- -1 window.opacity=0.85"
alias aoo="alacritty msg config -- -1 window.opacity=1"
alias hs='(){ echo $1 | hunspell -d hu_HU ;}'
alias es='(){ echo $1 | hunspell -d en_US ;}'
alias pdf='(){ nohup zathura $1 > /dev/null & }'

# Load host specific (untracked) aliases
source "$XDG_CONFIG_HOME/.aliases"
