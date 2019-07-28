echo "Configuring vim..."

# Redirect vimrc to .vim folder
echo "runtime vimrc" > $HOME/.vimrc

# install flake8 for vim-flake8
sudo apt-get install flake8

echo "Done!"
