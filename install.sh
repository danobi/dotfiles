#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

# Entry point
dir=~/dotfiles # dotfiles directory
olddir=$dir/dotfiles_old # old dotfiles backup directory
files="vimrc zshrc tmux.conf" # list of files/folders to symlink in homedir

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file $olddir   #Cannot stat errors are ok, it means old dotfiles did not exist
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# Install Vundle and TPM
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

install_zsh () {
# Test to see if zshell is installed. If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
    if [[ ! -d ~/.oh-my-zsh/ ]]; then
		git clone http://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh/
	fi
	# Set the default shell to zsh if it isn't currently set to zsh
	if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
		chsh -s $(which zsh)
	fi
else
	# If zsh isn't installed, get the platform of the current machine
	platform=$(uname);
	# If the platform is Linux, try an apt-get to install zsh and then recurse
	if [[ $platform == 'Linux' ]]; then
		if [[ -f /etc/redhat-release ]]; then
			sudo yum install zsh
			install_zsh
		elif [[ -f /etc/debian_version ]]; then
			sudo apt-get install zsh
			install_zsh
		elif [[ -f /etc/arch_release ]]; then
			sudo pacman -S zsh
			install_zsh
		else
			echo "Unhandled Linux distro - Please install zsh then re-run this script"
			exit
		fi
		# If the platform is OS X, tell the user to install zsh :)
	elif [[ $platform == 'Darwin' ]]; then
		echo "Please install zsh, then re-run this script"
		exit
	fi
fi
}

# install and chsh to zsh
install_zsh
