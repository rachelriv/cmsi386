#!/usr/bin/env python2
from warmup import change, strip_quotes, scramble, \
    powers_of_two, prefixes, interleave, stutter
import lines
import wordcount
import fifa2014group
import unittest


class WarmupTestCase(unittest.TestCase):
    def test_change(self):
        self.assertEqual(change(96), (3, 2, 0, 1))

    def test_strip_quotes(self):
        self.assertEqual(strip_quotes("a\"\"\'\"\"\"\"z"), 'az')

    def test_scramble(self):
        from collections import Counter
        self.assertEqual(Counter(scramble('Hello, world')),
                         Counter('Hello, world'))

    def test_powers_of_two(self):
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
        self.assertEqual(interleave(['a', 'b'], [1, 2, True, None]),
                         ['a', 1, 'b', 2, True, None])
        self.assertEqual(interleave([7, 3, 'dog'], [False]),
                         [7, False, 3, 'dog'])

    def test_stutter(self):
        self.assertEqual(stutter([5, 'dog', [3], 9]),
                         [5, 5, 'dog', 'dog', [3], [3], 9, 9])


class LineTestCase(unittest.TestCase):
    def test_lines(self):
        ''' Expects lines.py to accept a parameter to simulate raw_input '''
        # TODO: Simulate a file handle with StringIO
        line_test = '''
# A file
one

    two
        # yep, commented
###

three
 F O U R
        '''
        self.assertEqual(lines.lines(line_test), 4)


class WordCountTestCase(unittest.TestCase):
    def test_word_count(self):
        ''' expects wordcount.py to use a parameter to simulate stdin '''
        story = '''
Long, long ago they'd found
  an int -- anda long.
And a string!'''
        expected_output = '''
a 2
ago 1
an 1
and 2
found 1
int 1
long 3
string 1
they'd 1
        '''
        self.assertEqual(wordcount.wordcount(story), expected_output)


class FifaTestCase(unittest.TestCase):
    def test_fifa(self):
        proper_group = '''
Name             W  D  L
Netherlands      3  0  0
Chile            2  0  1
Spain            1  0  2
Australia        0  0  3
        '''
        self.assertEqual(fifa2014group.group('B'), proper_group)

if __name__ == '__main__':
    unittest.main()
