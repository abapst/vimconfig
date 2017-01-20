# Attempt to install gvim
if [ -f /usr/bin/gvim ]
then
  :
else
  sudo apt-get install vim-gtk
  if grep -Fxq "alias vim=/usr/bin/gvm" $HOME/.bashrc
  then
    :
  else
    echo "alias vim=/usr/bin/gvim" >> $HOME/.bashrc
  fi
fi

echo "runtime vimrc" >> $HOME/.vimrc

cp -a dotfiles/. $HOME
