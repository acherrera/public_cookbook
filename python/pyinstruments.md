# Pyinstruments testing

This is supposed to go through and check how long each part of the code takes, so let's try it. Documentation can be
found: https://pyinstrument.readthedocs.io/en/latest/guide.html#profile-a-python-script

Seems pretty easy to use - just install and run it instead of Python. Magic!


Best way to run is to run the program as you normally would and then go back and view the results in HTML. The HTML
viewer is pretty good


```python
    pyinstrument ./00_runme.py
    pyinstrument --load-prev 2021-09-17T11-02-18 -r html
 ```
