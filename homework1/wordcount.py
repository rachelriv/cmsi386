#!/usr/bin/env python2
"""A script that reads from standard input and prints a sequence of lines.

The lines contain:
1. a word from the file,
2. a single space, and
3. the number of times the word appears in the file.
"""

import sys
import re
from collections import Counter


def get_words(line):
    return re.split('[^a-zA-Z\']', line)


def add_to_counter_with_key_lowercased(counter, keys):
    counter.update(key.lower() for key in keys if key)


def sort_word_count_tuples_by_word(counter):
    return sorted(counter.items(), key=lambda x: x[0])


def format_word_count_tuples(pairs):
    """Return a formatted list of word count tuples.

    This formatting is handled automatically but now the
    code is Python3-ready.
    """
    return [' '.join(str(item) for item in pair) for pair in pairs]


c = Counter()
for line in sys.stdin:
    words = get_words(line)
    add_to_counter_with_key_lowercased(c, words)
sorted_word_count_tuples = sort_word_count_tuples_by_word(c)
formatted_word_count_tuples = format_word_count_tuples(sorted_word_count_tuples)
print '\n'.join(formatted_word_count_tuples)
