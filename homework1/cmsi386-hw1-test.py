from warmup import change, strip_quotes, scramble
from warmup import powers_of_two, prefixes
from warmup import interleave, stutter
from subprocess import call, check_output, Popen, PIPE, STDOUT
import uuid
import re
import unittest

class WarmupTestCase(unittest.TestCase):

    def test_change(self):
        self.assertEqual(change(97), (3, 2, 0, 2))
        self.assertEqual(change(8), (0, 0, 1, 3))
        self.assertEqual(change(250), (10, 0, 0, 0))
        self.assertEqual(change(0), (0, 0, 0, 0))
        self.assertEqual(change(41), (1, 1, 1, 1))
        self.assertEqual(change(25000001), (1000000, 0, 0, 1))
        self.assertRaises(ValueError, change, -201)

    def test_strip_quotes(self):
        self.assertEqual(strip_quotes(""), "")
        self.assertEqual(strip_quotes("Hello, world"), "Hello, world")
        self.assertEqual(strip_quotes("\"\'"), "")
        self.assertEqual(strip_quotes("a\"\"\'\"\"\"\"z"), "az")

    def test_scramble(self):
        data = ["", "a", "rat", "BSOD", "BDFL", "Python testing"]
        for s in data:
            self.assertEqual(sorted(s), sorted(scramble(s)))

    def test_powers_of_two(self):
        self.assertEqual(list(powers_of_two(60)), [1, 2, 4, 8, 16, 32])
        self.assertEqual(list(powers_of_two(63)), [1, 2, 4, 8, 16, 32])
        self.assertEqual(list(powers_of_two(64)), [1, 2, 4, 8, 16, 32, 64])
        self.assertEqual(list(powers_of_two(0)), [])
        self.assertEqual(list(powers_of_two(1)), [1])

    def test_prefixes(self):
        self.assertEqual(list(prefixes('')), [''])
        self.assertEqual(list(prefixes('a')), ['', 'a'])
        self.assertEqual(list(prefixes('ab')), ['', 'a', 'ab'])
        self.assertEqual(list(prefixes('abc')), ['', 'a', 'ab', 'abc'])

    def test_interleave(self):
        self.assertEqual(interleave([], []), [])
        self.assertEqual(interleave([1], []), [1])
        self.assertEqual(interleave([], [1]), [1])
        self.assertEqual(interleave([1], [1]), [1, 1])
        self.assertEqual(interleave([None], [None]), [None, None])
        self.assertEqual(interleave([None, None], [0]), [None, 0, None])
        self.assertEqual(interleave([0], [None, None]), [0, None, None])
        self.assertEqual(interleave([1], ['a', 'b', 'c', 'd']), [1, 'a', 'b', 'c', 'd'])
        self.assertEqual(interleave(['a', 'b', 'c', 'd'], [1]), ['a', 1, 'b', 'c', 'd'])

    def test_stutter(self):
        self.assertEqual(stutter([]), [])
        self.assertEqual(stutter([True]), [True, True])
        self.assertEqual(stutter([None]), [None, None])
        self.assertEqual(stutter([2, 'x', 5.5]), [2, 2, 'x', 'x', 5.5, 5.5 ])
        self.assertEqual(stutter([2, [3]]), [2, 2, [3], [3]])
        self.assertEqual(stutter([[[[[[None]]]]]]), [[[[[[None]]]]], [[[[[None]]]]]])
        self.assertEqual(stutter([{'x': 0}, 1]), [{'x': 0}, {'x': 0}, 1, 1])

    def test_lines(self):
        temporary_file_name = '/tmp/' + str(uuid.uuid4())
        with open(temporary_file_name, 'w') as f:
            f.write('\n')
            f.write('    \n')
            f.write('    one\n')
            f.write('two\n')
            f.write('       # comment\n')
            f.write('hash char not the first non-blank       # comment\n')
            f.write('# comment\n')
        data = check_output(['python', 'lines.py', temporary_file_name])
        call(['rm', temporary_file_name])
        self.assertTrue(re.match(r'^\s*3\s*$', data))

    def test_wordcount(self):
        file_contents = 'QQQ A abc\na  a\tHA:qQq'
        pipe = Popen(['python', 'wordcount.py'], stdout=PIPE, stdin=PIPE, stderr=STDOUT)
        data = pipe.communicate(input=file_contents)[0]
        self.assertTrue(re.match(r'^a 3\nabc 1\nha 1\nqqq 2\n*$', data))

    def test_fifa(self):
        data = check_output(['python', 'fifa2014group.py', 'G'])
        self.assertTrue(re.match(r'Name\s+W\s+D\s+L\nGermany\s+2\s+1\s+0\nUnited', data))


if __name__ == '__main__':
    unittest.main()
