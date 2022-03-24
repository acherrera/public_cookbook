"""
This is the main file. Run this file to see how the logging might work
"""

import logging
from module import some_function



# Get up for global logging
formatter = '%(asctime)s.%(msecs)d\t%(name)s\t%(levelname)s:\t%(message)s'
logname = f"./logfile.log"
logging.basicConfig(filemode='a',
        format=formatter,
        datefmt='%H:%M:%S',
        handlers=[
            logging.FileHandler(logname),
            logging.StreamHandler()
            ],
        level=logging.DEBUG)


if __name__ == "__main__":
    # Setup for local logger
    # Typical way - results in "__main__" in the log file
    # logger = logging.getLogger(__name__)

    logger = logging.getLogger("main")

    logger.info("======== Starting Run =========")
    logger.info("Running Some Mod")
    output = some_function()
    logger.info(f"Some function output: {output}")
    logger.info("======== Run Complete =========")

