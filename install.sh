#!/usr/bin/env bash

set -e

DIR=~/dotfiles/                   # dotfiles repo -- the repo *HAS* to be cloned into the home directory
DEFAULT_UNSTOW="vim zsh tmux"     # default packages to un-stow
DEFAULT_PKGS="zsh vim tmux stow"  # default OS packages to install

install_stuff () {
  # Figure out which package manager to use
  platform=$(uname)
  if [[ $platform == 'Linux' ]]; then
    if [[ -f /etc/redhat-release ]]; then
      PKG_MANAGER_CMD="sudo dnf install"
    elif [[ -f /etc/debian_version ]]; then
      PKG_MANAGER_CMD="sudo apt-get install"
    elif [[ -f /etc/arch_release ]]; then
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

  # chsh over to zsh
  chsh -s $(which zsh)
}

install_stuff

# Un-stow the default packages
cd $DIR
for package in ${DEFAULT_UNSTOW}; do
  stow $package
done
