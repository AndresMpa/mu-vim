#!/bin/bash

instalation_dir=~/.config/nvim

# Removing useless scripts
rm ./updateSnippets.sh

# Renaming dir
cd ..
mv nvim-configuration nvim

# Downloading tools
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

installed=1

if [ nvim ];
then
	echo "nvim"
elif [ vim ];
then
	echo "vim"
else
	installed=0
fi

# Installation for Arch
if [ `which pacman` == "/usr/bin/pacman" ];
then
	echo "pacman"
	sudo pacman -Syu nodejs npm
	if [ installed ];
	then
		sudo pacman -S neovim
	fi
# Installation for apt
elif [ `which apt` == "/usr/bin/apt" ];
then
	echo "apt"
	sudo apt-get install nodejs
	sudo apt-get install npm
	if [ installed ];
	then
		sudo apt-get install neovim
	fi
else
	echo "
	Sorry I don't know how to make this
	thing work in your OS yet, check the
	following links to install what you
	need manually"
fi

# Custom dirs functionality
echo "Are you using a custom config dir? (Default ~/.config)[y/n]: "
read custom_dir

if [ $custom_dir == "y" ];
then
	echo "Write your custom dir name: "
	read instalation_dir
fi

# Saving old configs
if [ -e ~/.config/nvim ];
then
	mv ~/.config/nvim old-nvim
	mv $(pwd) $instalation_dir
else
	if [ -e ~/.config ];
	then
		mv nvim $instalation_dir
	else
		mkdir ~/.config
		mv nvim $instalation_dir
	fi
fi

echo "
	Thanks to try my nvim config files,
	now, you need to close this terminal
	and start a new one to see the changes

	Then open the editor with:

	$ nvim

	Then enjoy...
	___

	Short documentation

	If you want to edit the config file
	go to:

	$ nvim ~/.config/nvim/init.vim

	There you can see the configs and
	some esthetic dependencies, highlight,
	themes, etc...
	___
"


