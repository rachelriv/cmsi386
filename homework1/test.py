#!/usr/bin/env python2
# coding=utf-8
"""A module containing all unit tests for other scripts in the directory."""
from warmup import change, strip_quotes, scramble, \
    powers_of_two, prefixes, interleave, stutter

import subprocess
import unittest
import os


class PythonWarmupTestCase(unittest.TestCase):

    """Tests for warmup.py methods."""

    def test_change(self):
        """Test valid US change for a number of cents.

        Expected format: [quarter, dime, nickle, penny]
        """
        self.assertEqual(change(97), (3, 2, 0, 2))
        self.assertEqual(change(33.25), (1.0, 0.0, 1.0, 3.25))
        self.assertEqual(change(8), (0, 0, 1, 3))
        self.assertEqual(change(250), (10, 0, 0, 0))
        self.assertEqual(change(0), (0, 0, 0, 0))
        self.assertEqual(change(41), (1, 1, 1, 1))
        self.assertEqual(change(25000001), (1000000, 0, 0, 1))
        self.assertRaises(ValueError, change, -201)
        self.assertRaises(TypeError, change, "foo")

    def test_strip_quotes(self):
        """Test stripping quotes from strings."""
        self.assertEqual(strip_quotes("a\"\"\'\"\"\"\"z"), 'az')
        self.assertEqual(strip_quotes("a\'z\"ggeiohg\\53785\""),
                         'azggeiohg\\53785')

    def test_scramble(self):
        """Test scrampling a string.

        Aside from ensuring that no characters are lost
        in the translation, this is rather hard to test
        programatically, because randomness can't easily
        be measured. Printing out the output shows this
        to be pseudorandom.
        """
        from collections import Counter
        self.assertEqual(Counter(scramble('Hello, world')),
                         Counter('Hello, world'))

    def test_powers_of_two(self):
        """Test iterator for all powers of two less than a given number."""
        pow2 = powers_of_two(70)
        self.assertEqual(next(pow2), 1)
        self.assertEqual(next(pow2), 2)
        self.assertEqual(next(pow2), 4)
        self.assertEqual(next(pow2), 8)
        self.assertEqual(next(pow2), 16)
        self.assertEqual(next(pow2), 32)
        self.assertEqual(next(pow2), 64)
        pow2 = powers_of_two(2)
        self.assertEqual(next(pow2), 1)
        self.assertEqual(next(pow2), 2)

    def test_prefixes(self):
        """Test iterator for letters in a string sequentially."""
        prefix = prefixes('vanrossum')
        self.assertEqual(next(prefix), '')
        self.assertEqual(next(prefix), 'v')
        self.assertEqual(next(prefix), 'va')
        self.assertEqual(next(prefix), 'van')
        self.assertEqual(next(prefix), 'vanr')
        self.assertEqual(next(prefix), 'vanro')
        self.assertEqual(next(prefix), 'vanros')
        self.assertEqual(next(prefix), 'vanross')
        self.assertEqual(next(prefix), 'vanrossu')
        self.assertEqual(next(prefix), 'vanrossum')

    def test_interleave(self):
        """Test combining two iterables into a single list."""
        self.assertEqual(interleave(['a', 'b'], [1, 2, True, None]),
                         ['a', 1, 'b', 2, True, None])
        self.assertEqual(interleave([7, 3, 'dog'], [False]),
                         [7, False, 3, 'dog'])

    def test_stutter(self):
        """Test doubling up all items in a single iterable."""
        self.assertEqual(stutter([5, 'dog', [3], 9]),
                         [5, 5, 'dog', 'dog', [3], [3], 9, 9])


class LineTestCase(unittest.TestCase):

    """Test determining number of non-blank, non-commented lines in a file."""

    def setUp(self):
        """Set up requisite variables and files."""
        self.filename = 'example.txt'
        file_lines = '# A file\n'
        file_lines += 'one\n'
        file_lines += '\n'
        file_lines += '    two\n'
        file_lines += '      # yep, commented\n'
        file_lines += '###\n'
        file_lines += '\n'
        file_lines += 'three\n'
        file_lines += '  F O U R\n'
        with open(self.filename, 'w') as f:
            f.write(file_lines)
            f.flush()

    def test_lines(self):
        """Execute the program and pass through filename."""
        args = ['python2', 'lines.py', self.filename]
        p = subprocess.Popen(args, stdout=subprocess.PIPE)
        self.assertEqual(int(p.communicate()[0].rstrip()), 4)

    def tearDown(self):
        """Clean up after ourselves."""
        os.remove(self.filename)


class WordCountTestCase(unittest.TestCase):

    """Test determining the number of words in a file.

    Does not include anything that isn't an ASCII letter or quotation mark.
    Output will be sorted.
    """

    def setUp(self):
        """Set up story and expected result in a nice easy to read fasion."""
        self.story = "Long, long agø they'd found\n"
        self.story += '  an int -- and a long.\n'
        self.story += 'And a string!\n'
        self.expected = 'a 2\n'
        self.expected += 'ag 1\n'
        self.expected += 'an 1\n'
        self.expected += 'and 2\n'
        self.expected += 'found 1\n'
        self.expected += 'int 1\n'
        self.expected += 'long 3\n'
        self.expected += 'string 1\n'
        self.expected += "they'd 1\n"

    def test_wordcount(self):
        """Test that wordcount is what we expect."""
        p = subprocess.Popen(['python2', 'wordcount.py'],
                             stdin=subprocess.PIPE,
                             stdout=subprocess.PIPE)
        self.assertEquals(p.communicate(input=self.story)[0], self.expected)


if __name__ == '__main__':
    unittest.main()
