# Attempt to install gvim
echo "Attempting to install gvim..."
sudo apt-get install vim-gtk > /dev/null

if grep -Fxq "alias vim=/usr/bin/gvim" $HOME/.bashrc
then
  :
else
  echo "alias vim=/usr/bin/gvim" >> $HOME/.bashrc
fi

echo "runtime vimrc" > $HOME/.vimrc

cp -a dotfiles/. $HOME

echo "Done!"
