import logging
import logging.config
import json
import os

logger = logging.getLogger(__name__)


def setup_logging(
    default_path='logging.json',
    default_level=logging.INFO,
    env_key='LOG_CFG'
):
    """
    Setup logging configuration
    """
    path = default_path
    value = os.getenv(env_key, None)
    if value:
        path = value
    if os.path.exists(path):
        with open(path, 'rt') as f:
            config = json.load(f)
        logging.config.dictConfig(config)
    else:
        logging.basicConfig(level=default_level)


def test_logging():
    logger.debug("Here is a debug statment!")
    logger.info("Here is a info statment!")
    logger.warning("Here is a warning statment!")
    logger.error("Here is a error statment!")
    logger.critical("Here is a critical statment!")

if __name__ == "__main__":
    setup_logging()
    test_logging()
