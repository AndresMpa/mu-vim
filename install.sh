#!/bin/bash

instalation_dir=~/.config/nvim

cd ..
mv nvim-configuration nvim

echo "Are you using a custom config dir? (Default ~/.config)[y/n]: "
read custom_dir

if [ $custom_dir == "y" ];
then
	echo "Write your custom dir name: "
	read instalation_dir
fi
	
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


