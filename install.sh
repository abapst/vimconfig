if [ -f $HOME/.vimrc ]; then
  rm $HOME/.vimrc
fi
if [ -f $HOME/.gtkrc-2.0 ]; then
  rm $HOME/.gtkrc-2.0
fi

cp -a dotfiles/. $HOME
