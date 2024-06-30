# Print out the system MOTD
cat /etc/motd

# Theme
ZSH_THEME="cleanified"

# Plugins
plugins=(zsh-autosuggestions zsh-syntax-highlighting vi-mode)

# Sourcing oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Instant autocomplete
setopt menu_complete

# Keybinds
bindkey -M viins 'jk' vi-cmd-mode

# Custom Aliases
alias vim="nvim"
alias py="python3"
alias pip="python3 -m pip"
alias reloadzsh="source $ZDOTDIR/.zshrc"
alias gitr="~/.dotfiles/bin/gitea_remote_updater.sh"
alias ls="ls --group-directories-first --color=auto"
alias pmphf="~/.dotfiles/bin/pmphf.sh"
alias pyvenv="source venv/bin/activate"
alias diffdir="diff -bur"
alias info="info --vi-keys"
alias ao="alacritty msg config -- -1 window.opacity=0.85"
alias aoo="alacritty msg config -- -1 window.opacity=1"
alias tree="tree --dirsfirst"
