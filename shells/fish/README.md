## Fish Shell

Install fish shell and set as default. Note - ONLY use fish or zsh. You can't really have two shells, so make up your mind.

```
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install fish
sudo chsh $USER
> /bin/fish
```

Now, get oh my fish.
```
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

#EXAMPLE - Get the theme "dangerous" 
omf install dangerous
omf theme dangerous
```
