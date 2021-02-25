#!/bin/sh
# Usage: install.sh [<home_directory_path>]

if [ "$#" -ne 1 ]; then
  homedir=$HOME
  echo "Setting up dotfiles for $USER"
else
  homedir=$1
  echo "Setting up dotfiles in $homedir"
fi

setup_zsh()
{
  sudo apt install zsh
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  chsh -s $(which zsh)
}

# ZSH setup (Optional)
while true; do
  read -p "Do you want to install zsh & setup oh-my-zsh? (y/n) " opts
  case $opts in
    [Yy]* ) setup_zsh; break;;
    [Nn]* ) break;;
  esac
done

dotfilesdir=${homedir}/.dotfiles

# These files will get symlinked to the home dir
base_dotfiles="vimrc zshrc gitconfig tmux.conf"

# Changing dir to the dotfiles location
cd ${dotfilesdir}

# Symlinking the base dotfiles to the home dir
for file in ${base_dotfiles}; do
  echo "Symlinking .${file}"
  ln -sf ${dotfilesdir}/.${file} ${homedir}/.${file}
done

# Linking other files

## Oh-My-Zsh Custom Theme
custom_themes=".oh-my-zsh/custom/themes"
ln -sf ${dotfilesdir}/${custom_themes}/cleanified.zsh-theme ${homedir}/${custom_themes}/cleanified.zsh-theme

# Install ZSH plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Basic Binaries (Optional)
while true; do
  read -p "Do you want to install some basic binaries? (y/n) " optb
  case $optb in
    [Yy]* ) ./install_binaries.sh; break;;
    [Nn]* ) break;;
  esac
done

# Vim-Plug (Optional)
while true; do
  read -p "Do you want to install vim-plug as your vim plugin manager? (y/n) " optp
  case $optp in
    [Yy]* ) curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim; break;;
    [Nn]* ) break;;
  esac
done

echo "You are all set! 🎉🎉"

