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
c = Counter()
for line in sys.stdin:
    words = re.split('[^a-zA-Z\']', line)
    c.update(word.lower() for word in words if len(word) > 0)
sorted_words = sorted(list(c.items()), key=lambda x: x[0])
formatted_words = [' '.join(str(p) for p in pair) for pair in sorted_words]
print '\n'.join(formatted_words)
