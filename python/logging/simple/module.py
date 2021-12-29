import logging
from random import randint

# Use this class to log - it will add the module in the logs
logger = logging.getLogger(__name__)

def some_function():
    """
    Just using this to test logging
    """

    a = randint(0,10)
    b = randint(0,10)
    logger.info(f"Adding {a} and {b}")

    return a+b
