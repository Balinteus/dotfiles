#!/bin/zsh

# Load some helper libraries
for lib ("$ZSH/libs/"*.zsh); do
	source $lib
done

# Load plugins specified in .zshrc
for plugin ($plugins); do
	source "$ZSH/plugins/$plugin/$plugin.plugin.zsh"
done

# Load the theme from $ZSH_THEME
source "$ZSH/themes/$ZSH_THEME.zsh-theme"
