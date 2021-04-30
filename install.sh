#!/bin/bash

cd ..
mv nvim-configuration nvim

if [ -e ~/.config/nvim ];
then
	mv ~/.config/nvim old-nvim
	mv $(pwd) ~/.config/nvim
else
	if [ -e ~/.config ];
	then
		mv nvim ~/.config/nvim
	fi
		mkdir ~/.config
		mv nvim ~/.config/nvim
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

