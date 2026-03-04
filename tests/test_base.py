import unittest
import os.path
from pathlib import Path

import cowl


TEST_DIR = Path(__file__).parent
RES_DIR = TEST_DIR / "res"


class BasicTest(unittest.TestCase):
    """Tests if the library is installed and can be imported"""

    def test_cowl_installed(self):
        path = str(os.path.join(RES_DIR, 'test.owl'))
        manager = cowl.Manager()
        ontology = manager.read_path(path)
        self.assertIsNotNone(ontology)

    def test_print(self):
        path = str(os.path.join(RES_DIR, 'test.owl'))
        manager = cowl.Manager()
        ontology = manager.read_path(path)
        manager.write_path(ontology, "temp.owl")
        test_string = manager.write_str(ontology)

        ontology2 = manager.read_path("temp.owl")
        test_string2 = manager.write_str(ontology2)
        self.assertEqual(test_string, test_string2)
        print(test_string2)
        os.remove('temp.owl')

if __name__ == '__main__':
    unittest.main()

