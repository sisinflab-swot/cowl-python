import unittest
import sys
import unittest
import gc
import cowl

# Importa la classe di test
from test_base import BasicTest

if __name__ == "__main__":
    # Forza flush immediato dell'output
    sys.stdout.reconfigure(line_buffering=True)

    suite = unittest.TestLoader().loadTestsFromTestCase(BasicTest)

    # Runner con più output
    runner = unittest.TextTestRunner(verbosity=2)

    print("\n=== AVVIO TEST SUITE ===\n")
    runner.run(suite)
    print("\n=== FINE TEST SUITE ===\n")