# Setup

This is an attempt to keep track of what needs to be done to setup a new generic laptop.

## Installation and Configuration


Basic setup 
```
ssh-keygen
# Add key to git

git clone <THIS_REPO>


# Tmux setup
sudo apt install tmux
cp ./tmux/tmux.conf ~/.tmux.conf

```


Neovim setup

```
# Neovim
# Install neovim
sudo apt install snapd
sudo snap install nvim --classic

# Get add-ons for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Get node
curl -sL install-node.vercel.app/lts > runme.sh
chmod +x ./runme.sh
sudo ./runme.sh

# Open vim and run 
# :PlugInstall
# :CocInstall coc-python
# :CocInstall coc-json
```
