#!/bin/sh
# Requirements:
#   - git, curl, stow installed
#   - ZSH set as the default shell
#   - For full desktop setup: dconf

# Constants
PREFIX_HEADER="\e[0;33;1m"
PREFIX_SUCCESS="\e[0;32;1m"
PREFIX_ADDITION="\e[0;32;1m[+]"
PREFIX_LINKING="\e[1;34;1m[<->]"
X="\e[0m"

# We need to source .zshenv for ourselves
source "$HOME/.dotfiles/linux/.config/zsh/.zshenv"

init()
{
  echo -e "${PREFIX_HEADER}LINUX SETUP SCRIPT$X\n"

  while true; do
    echo -e "${PREFIX_HEADER}Install options:$X
\t[1] Minimal install
\t[2] Full desktop install"
    read optp
    case $optp in
      [1] ) minimal_setup; break;;
      [2] ) full_setup; break;;
    esac
  done
}

minimal_setup()
{
  # Make sure that the specified XDG base dirs exist
  if [[ ! -d $XDG_CONFIG_HOME ]]; then mkdir -p $XDG_CONFIG_HOME; fi
  if [[ ! -d $XDG_DATA_HOME ]]; then mkdir -p $XDG_DATA_HOME; fi

  # Choose the prefered editor
  while true; do
    echo -e "${PREFIX_HEADER}Which editor would you \
like to setup?$X\n\t[1] Vim\n\t[2] Neovim\n\t[3] Both Vim and Neovim"
    read optv
    case $optv in
      [1] )
        PREF_EDITOR=(vim)
        break;;
      [2] )
        PREF_EDITOR=(nvim)
        break;;
      [3] )
        PREF_EDITOR=(vim nvim)
        break;;
    esac
  done
  for EDT in "${PREF_EDITOR[@]}"; do
    echo -e "${PREFIX_LINKING} Symlinking $EDT...$X"
    if [[ ! -d $XDG_CONFIG_HOME/$EDT ]]; then
      mkdir $XDG_CONFIG_HOME/$EDT
    fi
    stow -d "$DOTFILES_DIR/linux/.config" -t "$XDG_CONFIG_HOME/$EDT" $EDT
  done

  # Install vim-plug as the plugin manager for (n)vim
  while true; do
    echo -e "${PREFIX_HEADER}Do you want to install vim-plug as your (n)vim \
plugin manager? (y/n)$X "
    read optp
    case $optp in
      [Yy]* )
        if [[ $optv -eq 1 ]] || [[ $optv -eq 3 ]]; then
          curl -fLo "$XDG_CONFIG_HOME/vim/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        fi
        if [[ $optv -eq 2 ]] || [[ $optv -eq 3 ]]; then
          curl -fLo "$XDG_DATA_HOME/nvim/site/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        fi
        break;;
      [Nn]* ) break;;
    esac
  done

  # Linking essential configs
  echo -e "${PREFIX_LINKING} Symlinking essential CLI config files:$X"
  ESSENTIAL_CONFIGS=(zsh git tmux)
  for CONF in "${ESSENTIAL_CONFIGS[@]}"; do
    # Linking configs
    echo -e "\t- $CONF"
    mkdir $XDG_CONFIG_HOME/$CONF
    stow -d "$DOTFILES_DIR/linux/.config" -t "$XDG_CONFIG_HOME/$CONF" $CONF

    # Linking data files
    if [[ -d "$DOTFILES_DIR/linux/.local/share/$CONF" ]]; then
      if [[ ! -d "$XDG_DATA_HOME/$CONF" ]]; then
        mkdir -p "$XDG_DATA_HOME/$CONF"
      fi
      stow -d "$DOTFILES_DIR/linux/.local/share" -t "$XDG_DATA_HOME/$CONF" $CONF
    fi
  done

  # Linking scripts
  echo -e "${PREFIX_LINKING} Linking scripts..."
  if [[ ! -d "$SCRIPTS_HOME" ]]; then mkdir -p "$SCRIPTS_HOME"; fi
  stow -d "$DOTFILES_DIR/linux/.local" -t "$SCRIPTS_HOME" bin

  # Installing ZSH plugins
  while true; do
    echo -e "${PREFIX_HEADER}Do you want to install the ZSH plugins? (y/n)$X"
    read opts
    case $opts in
      [Yy]* )
        echo -e "${PREFIX_ADDITION} Cloning custom zsh plugins...$X"
        cat $DOTFILES_DIR/linux/.config/zsh/zsh-plugins |
          sed "s|*|${ZSH}|g"                            |
          xargs -L 1 -r git clone
        break;;
      [Nn]* ) break;;
    esac
  done

  echo -e "${PREFIX_SUCCESS}Finished setting up the CLI!$X"
}

full_setup()
{
  # Setup the CLI
  minimal_setup

  # Link the rest of the config files & data files
  echo -e "${PREFIX_LINKING} Linking all the other config files...$X"
  stow -d "$DOTFILES_DIR/linux" -t "$XDG_CONFIG_HOME" .config
  stow -d "$DOTFILES_DIR/linux/.local" -t "$XDG_DATA_HOME" share

  # Link the templates dir
  source "$DOTFILES_DIR/linux/.config/user-dirs.dirs"
  if [[ ! -d "$XDG_TEMPLATES_HOME" ]]; then mkdir -p "$XDG_TEMPLATES_DIR"; fi
  stow -d "$DOTFILES_DIR/linux/.local" -t "$XDG_TEMPLATES_DIR" templates

  # Load the Cinnamon configs
  while true; do
    echo -e "${PREFIX_HEADER}Do you want to setup Cinnamon? (y/n)$X"
    read optcc
    case $optcc in
      [Yy]* )
        echo -e "${PREFIX_ADDITION} Loading the Cinnamon config files...$X"
        dconf load /org/cinnamon/ < $DOTFILES_DIR/linux/.config/cinnamon.conf
        break;;
      [Nn]* ) break;;
    esac
  done

  echo -e "${PREFIX_SUCCESS}Finished setting up the GUI!$X"
}

init

echo -e "${PREFIX_SUCCESS}You are all set! 🎉🎉$X"
