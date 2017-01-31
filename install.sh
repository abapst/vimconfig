echo "Installing vim config..."

# Add gvim alias to bashrc
if grep -Fxq "alias vim=/usr/bin/gvim" $HOME/.bashrc
then
  :
else
  echo "alias vim=/usr/bin/gvim" >> $HOME/.bashrc
fi

# Redirect vimrc to .vim folder
echo "runtime vimrc" > $HOME/.vimrc

echo "Done!"
