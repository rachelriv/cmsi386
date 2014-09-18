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


def add_to_counter(counter, words):
    """Add each word in the words list to a Counter instance.

    Each word in the words list should be a string.
    All words are converted to lowercase prior to being inserted
    into the Counter instance.
    """
    counter.update(word.lower() for word in words if len(word) > 0)


def sort_pairs(counter):
    """Return a list representing the counter's pairs in sorted order.

    Return a list of (key, count) pairs sorted by key.
    """
    return sorted(counter.items(), key=lambda x: x[0])


def format(pairs):
    """Return a formatted list of pairs.

    Return a list of strings where each string is a key
    and and value of the pair separated by a single space.
    """
    return [' '.join(str(item) for item in pair) for pair in pairs]


c = Counter()
for line in sys.stdin:
    words = get_words(line)
    add_to_counter(c, words)
sorted_wordcounts = sort_pairs(c)
formatted_wordcounts = format(sorted_wordcounts)
print '\n'.join(formatted_wordcounts)
