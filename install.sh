#!/usr/bin/env bash

set -e

DIR=~/dotfiles/   # dotfiles repo -- the repo *HAS* to be cloned into the home directory
DEFAULT_UNSTOW="vim fish tmux git alacritty bin"
DEFAULT_PKGS="fish vim tmux git stow ctags"

install_stuff () {
  # Figure out which package manager to use
  platform=$(uname)
  if [[ $platform == 'Linux' ]]; then
    if [[ -f /etc/redhat-release ]]; then
      PKG_MANAGER_CMD="sudo dnf install"
    elif [[ -f /etc/debian_version ]]; then
      PKG_MANAGER_CMD="sudo apt-get install"
    elif [[ -f /etc/arch-release ]]; then
      PKG_MANAGER_CMD="sudo pacman -S"
    else
      echo "Unhandled Linux distro -- giving up forever"
      exit 1
    fi
  elif [[ $platform == 'Darwin' ]]; then
    echo "OSX is unhandled for now -- giving up forever"
    echo "TODO: automate installation of homebrew and then continue"
    exit 1
  fi

  # Let's install some packages
  $PKG_MANAGER_CMD $DEFAULT_PKGS

  # Let's clone some specific git repos
  if [[ ! -d ~/.vim/bundle/Vundle.vim ]]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  fi
  if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi

  # Move the colliding .config/fish so stow doesn't error out
  if [ -d ~/.config/fish ]; then
    mv ~/.config/fish ~/.config/fish.old
  fi
}

post_install () {
  # Un-stow the default packages
  # This has to go first in this function
  cd $DIR
  for package in ${DEFAULT_UNSTOW}; do
    stow $package
  done

  # Install tmux plugins
  ~/.tmux/plugins/tpm/bin/install_plugins

  # Install vim plugins
  vim +PluginInstall +qall

  # chsh over to fish
  chsh -s $(which fish)
}

install_stuff
post_install
