# Python

I've done a LOT with Python and most things I can remember. But these are a few of things that are particularly
challenging and useful enough that I would like to have on hand. 


## Black

Formatted. Use it. It is amazing. `pip install black`

```
    # Check and then reformat
    black --check . 
    black .

    # Check and reformat with exclusions:
    black . --exclude "\.git|\.tox|venv2/|venv3/|\.undodir/" --check
    black . --exclude "\.git|\.tox|venv2/|venv3/|\.undodir/"
```

## Poetry

Package manager that keeps track of what everything and makes sure you aren't download 10 versions of that same thing.
Get with `pip install poetry`

Quick guide
```
    poetry init
    poetry run ./some_file.py

    # Just use the virtual env
    poetry shell 

    # Adding and install modules
    poetry add some_module
    poetry add --dev some_dev_module
    poetry install
```
