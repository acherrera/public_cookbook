# Rotating log files

Found here: https://www.blog.pythonlibrary.org/2014/02/11/python-how-to-create-rotating-logs/

This method doesn't use the basic handler, but instead will manually add handler to the base log?


## Rotate Based on Size

This will create a log, and add some test data and rotate the file base on size - here set to 20 btyes which is rather
small

```
import logging
import time
from logging.handlers import RotatingFileHandler
#----------------------------------------------------------------------
def create_rotating_log(path):
    """
    Creates a rotating log
    """
    logger = logging.getLogger("Rotating Log")
    logger.setLevel(logging.INFO)
    
    # add a rotating handler
    handler = RotatingFileHandler(path, maxBytes=20,
                                  backupCount=5)
    logger.addHandler(handler)
    
    for i in range(10):
        logger.info("This is test log line %s" % i)
        time.sleep(1.5)
        
#----------------------------------------------------------------------
if __name__ == "__main__":
    log_file = "test.log"
    create_rotating_log(log_file)

```

## Rotate Based on Time

This will rotate the log files based on time:

Here are the abbreviations:
    - second (s)
    - minute (m)
    - hour (h)
    - day (d)
    - w0-w6 (weekday, 0=Monday)
    - midnight

In this case it will also keep some back ups as well.

```
import logging
import time
from logging.handlers import TimedRotatingFileHandler
#----------------------------------------------------------------------
def create_timed_rotating_log(path):
    """"""
    logger = logging.getLogger("Rotating Log")
    logger.setLevel(logging.INFO)
    
    handler = TimedRotatingFileHandler(path,
                                       when="m",
                                       interval=1,
                                       backupCount=5)
    logger.addHandler(handler)
    
    for i in range(6):
        logger.info("This is a test!")
        time.sleep(75)
#----------------------------------------------------------------------
if __name__ == "__main__":
    log_file = "timed_test.log"
    create_timed_rotating_log(log_file)
```

## Using outside of the examples 
