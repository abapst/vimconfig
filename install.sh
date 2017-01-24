# Attempt to install gvim
sudo apt-get install vim-gtk

# Install libgtk2.0 for fullscreen support in Ubuntu 16.04
sudo apt-get install libgtk2.0

# Add gvim alias to bashrc
if grep -Fxq "alias vim=/usr/bin/gvim" $HOME/.bashrc
then
  :
else
  echo "alias vim=/usr/bin/gvim" >> $HOME/.bashrc
fi
exec bash

# Redirect vimrc to .vim folder
echo "runtime vimrc" > $HOME/.vimrc

# Copy modified gtkrc script to home
cp -a dotfiles/. $HOME

echo "Done!"
