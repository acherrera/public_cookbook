## NeoVim

Including this with VIM because they are basically the same thing.


Installing from source:
```
# Get neovim setup

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage
```


Installing from apt - note that this is sometimes a little behind the times. May not work with everything if it is too
far behind.
```
# If you want, give this a try
sudo apt install neovim
sudo apt remove vim
alias vim=neovim
mkdir ~/.config/nvim/
cp ./rc_file/vimrc ~/.config/nvim/init.vim
```


Get all the plugins. Don't do this if you are running on a very small machine. If you must, make sure to only use the
plugins that you couldn't live without since they can use quite a bit of processing power.
```
# Get Plug for Plugins (for neovim)
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Needed for CoC to work
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
sudo apt -y install nodejs

# Getting Ag to work
sudo apt install silversearcher-ag
```

Open nvim and run `:PlugInstall` and `:CocInstall coc-tabnine` - this will install tab-nine completion. Cool, that
should have worked without a huge issue


## FZF

Fuzzy find itself is pretty cool, but this provides some insane methods to search through a project. This
basically allows you to search through anything in VIM with fuzzy finder.

Found here: https://github.com/junegunn/fzf.vim

Add this with Plug:

```
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
```

Commands for FZF - things you can now search with FZF:

    - Files [PATH] 	    Files (runs $FZF_DEFAULT_COMMAND if defined)
    - GFiles [OPTS] 	Git files (git ls-files)
    - GFiles? 	        Git files (git status)
    - Buffers 	        Open buffers
    - Colors 	        Color schemes
    - Ag [PATTERN] 	    ag search result (ALT-A to select all, ALT-D to deselect all)
    - Rg [PATTERN] 	    rg search result (ALT-A to select all, ALT-D to deselect all)
    - Lines [QUERY] 	Lines in loaded buffers
    - BLines [QUERY] 	Lines in the current buffer
    - Tags [QUERY] 	    Tags in the project (ctags -R)
    - BTags [QUERY] 	Tags in the current buffer
    - Marks 	        Marks
    - Windows 	        Windows
    - Locate PATTERN 	locate command output
    - History 	        v:oldfiles and open buffers
    - History: 	        Command history
    - History/ 	        Search history
    - Snippets 	        Snippets (UltiSnips)
    - Commits 	        Git commits (requires fugitive.vim)
    - BCommits 	        Git commits for the current buffer; visual-select lines to track changes in the range
    - Commands 	        Commands
    - Maps 	            Normal mode mappings
    - Helptags 	        Help tags 1
    - Filetypes 	    File types


#### FZF Automagically

These are added to vimrc to do fzf magic:

```
    nmap <Leader>B :Buffer<CR>
    nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
```

This runs the Buffer command with no arguments and the Ag command with the word under the cursor. Buffer command is
useful for hoping between files when a group decides to program in Python like it's Java.
