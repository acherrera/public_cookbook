
# Logging in the program

This should be at the top of each program that is using the logging module. You could use `logging.info` directly, but
this way allows you to see where the logs are coming from and set level on an individual basis

    import logging
    logger = logging.getLogger("logger_name")  # Manually setting the logger name
    logger = logging.getLogger(__name__) # Automatically set it to the name of file it is running in

Now just use the logger as you would use a print statement

    logger.debug("Some debug string")
    logger.info("Some info string")
    logger.warn("Some warning string")
    logger.error("Some error string")
    logger.critical("Some critical string")

# Global set up

Put this in a location that is guaranteed to run. For example "__init__.py". Also have seen this put in "logging.py"
but I am unsure if this is loaded automatically or now.

    # Set general confiugration information
    logging.basicConfig( level=logging.DEBUG, format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",

    # Set level per module - debug has a LOT of output otherwise
    logging.getLogger("botocore").setLevel(logging.WARNING)
    logging.getLogger("boto3").setLevel(logging.WARNING)
    logging.getLogger("urllib3").setLevel(logging.WARNING)
    logging.getLogger("s3transfer").setLevel(logging.WARNING)


# JSON file setup

The handlers are what, well, handles the data coming out of the logger. Here we are setting up an output to the console,
an output to an info log and an output to an error log. This was we can see everything but then only store INFO and
ERROR messages. 

The RotatingFileHandler will keep the log files from getting to large.

```json
    {
      "version": 1,
      "disable_existing_loggers": false,
      "formatters": {
        "simple": {
          "format": "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
        }
      },

      "handlers": {
        "console": {
          "class": "logging.StreamHandler",
          "level": "DEBUG",
          "formatter": "simple",
          "stream": "ext://sys.stdout"
        },

        "info_file_handler": {
          "class": "logging.handlers.RotatingFileHandler",
          "level": "INFO",
          "formatter": "simple",
          "filename": "info.log",
          "maxBytes": 10485760,
          "backupCount": 20,
          "encoding": "utf8"
        },

        "error_file_handler": {
          "class": "logging.handlers.RotatingFileHandler",
          "level": "ERROR",
          "formatter": "simple",
          "filename": "errors.log",
          "maxBytes": 10485760,
          "backupCount": 20,
          "encoding": "utf8"
        }
      },

      "loggers": {
        "my_module": {
          "level": "ERROR",
          "handlers": ["console"],
          "propagate": false
        }
      },

      "root": {
        "level": "INFO",
        "handlers": ["console", "info_file_handler", "error_file_handler"]
      }
      }
  ```
