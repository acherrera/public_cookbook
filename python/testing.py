"""
Example of testing
"""

from module.sub_mod import some_func
import unittest
from unittest.mock import patch, MagicMock, call

class TestCheckCache(unittest.TestCase):

    def setUp(self):

        # Standard setup
        patcher1 = patch(
            "module.sub_mod.os"
        )
        self.mock_os = patcher1.start()
        self.addCleanup(patcher1.stop)

        patcher2 = patch(
            "module.sub_mod.boto3"
        )
        self.mock_os = patcher2.start()
        self.addCleanup(patcher2.stop)


    def test_some_fun1(self):
        output = some_fun("asdf")
        self.assertIsNotNone(output)
        self.mock_os.listdir.assert_called_once()
