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
    """Return a list containing all words in a line.

    A word is any contiguous sequence of ASCII letters
    and apostrophes.
    """
    return re.split('[^a-zA-Z\']', line)


def add_to_counter(counter, keys):
    """Add each key in the keys list to a Counter instance.

    Each key in the key list should be a string.
    All key strings are converted to lowercase prior to being inserted
    into the Counter instance.
    """
    counter.update(key.lower() for key in keys if key)


def sort_pairs(counter):
    """Return a list representing the counter's pairs in sorted order.

    Return a list of (key, count) tuples sorted by key.
    """
    return sorted(counter.items(), key=lambda x: x[0])


def format_pairs(pairs):
    """Return a formatted list of pairs.

    Return a list of strings where each string is the key
    and value of a pair separated by a single space. pairs
    should be a list of tuples.
    """
    return [' '.join(str(item) for item in pair) for pair in pairs]


c = Counter()
for line in sys.stdin:
    words = get_words(line)
    add_to_counter(c, words)
sorted_wordcount_pairs = sort_pairs(c)
formatted_wordcount_pairs = format_pairs(sorted_wordcount_pairs)
print '\n'.join(formatted_wordcount_pairs)
