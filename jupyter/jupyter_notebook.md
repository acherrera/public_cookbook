# Commands and tips for Jupyter notebook
## Dark themes

Note - this can be a real pain if not right. It's nice, but not required to be happy. 

Use jupyterthemes and some magic. Must `pip install jupyterthemes` for this to work 

Use this command to set the jupter css file to be dark and awesome all at once

    jt -t monokai -fs 95 -tfs 11 -nfs 115 -cellw 88% -T -f fira

Add this to ~/.ipython/profile_default/startup/startup.ipy to use the theme for plotting as well as.

    # import jtplot submodule from jupyterthemes
    from jupyterthemes import jtplot

    # currently installed theme will be used to
    # set plot style if no arguments provided jtplot.style()
