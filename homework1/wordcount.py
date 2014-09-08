#!/usr/bin/env python2
"""A script that reads a file from standard input and writes,
 to standard output, a sequence of lines containing
  (1) a word from the file,
  (2) a single space, and
  (3) the number of times the word appears in the file."""

import sys
import re
from collections import Counter
c = Counter()
for line in sys.stdin:
    words = re.split('[^a-zA-Z\']', line)
    words = [word.lower() for word in words if word]
    c.update(words)
sorted_words = sorted(list(c.items()), key=lambda x: x[0])
formatted_words = ['{0} {1}'.format(*pair) for pair in sorted_words]
print '\n'.join(formatted_words)
