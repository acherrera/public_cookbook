# Bash


Move the `./bashrc` file to `~/.bashrc`.


## Creating functions

Create alias with the ability to pass values into the alias

    some_func(){
        INPUT1 = $1
        do_something $INPUT!
    }
