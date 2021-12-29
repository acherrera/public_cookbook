# Jupyter Notebook Notes

Jupyter Notebooks is a way of testing out Python code interactively.


## Running on Remote Server

 This is super cool as it will allow you to run a notebook on a huge computer and feed the results back through and SSH
 connection. Taken from the Anaconda documentation at: https://docs.anaconda.com/anaconda/user-guide/tasks/remote-jupyter-notebook/

On server run: `jupyter-notebook --no-browser --port=<PORT>` where <PORT> is the port number you want to use. If not
specificed, will use default port 8080. 

On the client machine rung `ssh -L 8080:localhost:<PORT> <REMOTE_USER>@<REMOTE_HOST>` where <PORT> is the port
specificed above and the <REMOTE_USER> and <REMOTE_HOST> is what you would normall use to connect. The `-L` option
specifies that the port is to be forwared to the remote address.
