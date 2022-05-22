# Installing a New Python Version

This can be done with a few fancy commands. This example will be done with Python3.10, but it should work for any version

First, get the repository for new python version:

```
	sudo add-apt-repository ppa:deadsnakes/ppa
	sudo apt update
```

Check to make sure it worked with: `apt list | grep python3.10`


Now install with `sudo apt install python3.10`

## Setting as Default

You can set a default python version with by opening `/usr/bin/gnome-terminal` and setting the first line to the new version

Next, update with `sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10`

Finally, `sudo update-alternatives --config python3`

## Fixing Errors with Pip and Disutils

Once the new python is installed, will need to update some packages to get everything working as intended.

```
	sudo apt remove --purge python3-apt
	sudo apt autoclean
	sudo apt install python3-apt
	sudo apt install python3.10-distutils
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	sudo python3.10 get-pip.py
	sudo apt install python3.10-venv
```

Now you should  be good to go
