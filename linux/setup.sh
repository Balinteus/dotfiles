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

setup_omz()
{
  echo -e "${PREFIX_ADDITION} Installing oh-my-zsh...$X"
  omz_url="https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
  sh -c "$(curl -fsSL $omz_url)" "" --unattended --keep-zshrc

  echo -e "${PREFIX_ADDITION} Cloning custom zsh plugins...$X"
  cat $DOTFILES_DIR/linux/.config/zsh/zsh-plugins
    | sed "s|*|${ZSH}|g"
    | xargs -L 1 -r git clone

  # Linking the omz custom configs
  echo -e "${PREFIX_LINKING} Symlinking omz configs...$X"
  stow -d "$DOTFILES_DIR/linux/.local/share" -t "$XDG_DATA_HOME/oh-my-zsh" oh-my-zsh
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

  # Linking essential configs (except omz's)
  echo -e "${PREFIX_LINKING} Symlinking essential CLI config files:$X"
  ESSENTIAL_CONFIGS=(zsh git tmux)
  for CONF in "${ESSENTIAL_CONFIGS[@]}"; do
    echo -e "\t- $CONF"
    mkdir $XDG_CONFIG_HOME/$CONF
    stow -d "$DOTFILES_DIR/linux/.config" -t "$XDG_CONFIG_HOME/$CONF" $CONF
  done

  # OMZ setup
  while true; do
    echo -e "${PREFIX_HEADER}Do you want to setup oh-my-zsh? (y/n)$X"
    read opts
    case $opts in
      [Yy]* ) setup_omz; break;;
      [Nn]* ) break;;
    esac
  done

  echo -e "${PREFIX_SUCCESS}Finished setting up the CLI!$X"
}

full_setup()
{
  # Setup the CLI
  minimal_setup

  # Link the rest of the config files
  echo -e "${PREFIX_LINKING} Linking all the other config files...$X"
  stow --dir="$DOTFILES_DIR/linux" --target="$XDG_CONFIG_HOME" .config
  stow --dir="$DOTFILES_DIR/linux/.local" --target="$XDG_DATA_HOME" share

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

echo -e "${PREFIX_SUCCESS}You are all set! 🎉🎉$X"
