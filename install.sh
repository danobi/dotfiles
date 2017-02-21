#!/usr/bin/env bash

set -e

DIR=~/dotfiles/   # dotfiles repo -- the repo *HAS* to be cloned into the home directory
DEFAULT_UNSTOW="vim zsh tmux git oh-my-zsh"
DEFAULT_PKGS="zsh vim tmux git stow ctags"

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
  if [[ ! -d ~/.oh-my-zsh/ ]]; then
    git clone http://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh/
  fi
  if [[ ! -d ~/.vim/bundle/Vundle.vim ]]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  fi
  if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi

  # Move the colliding .zshrc so stow doesn't error out
  if [[ -e ~/.zshrc ]]; then
    if [[ -e ~/.zshrc_OLD ]]; then
      rm ~/.zshrc_OLD
    fi
    mv ~/.zshrc ~/.zshrc_OLD
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

  # chsh over to zsh
  chsh -s $(which zsh)
}

install_stuff
post_install
