# Basic environment variables
export TERMINAL="alacritty"
export EDITOR="nvim"
export BROWSER="firefox"

# GUI Theming
export QT_QPA_PLATFORMTHEME="qt5ct"
#export GTK_THEME="Windows-10-Dark"

# Enable GPG signing
export GPG_TTY=$(tty)

# Colored MAN pages
export GROFF_NO_SGR=1
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# History file settings
export HISTSIZE=100000000
export SAVEHIST=100000000

# RFC 3339 like date format for ls invocations
export TIME_STYLE="long-iso"

# Setting XDG Base directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Pointing directories/files to XDG Base Directories
# (to remove junk from the home directory)
export ZDOTDIR="$HOME/.config/zsh"
export ZSH="$XDG_DATA_HOME/oh-my-zsh"
export UNISON="$XDG_DATA_HOME/unison"
export RANDFILE="$XDG_CACHE_HOME/.rnd"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST"
export OMNISHARPHOME="$XDG_CONFIG_HOME/omnisharp"
export ANDROID_USER_HOME="$XDG_DATA_HOME/android"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
