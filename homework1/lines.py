#!/usr/bin/env python2
# found file opening approach here: http://stackoverflow.com/questions/845058/
"""A script reporting the number of lines in a file.

The script only counts non-blank, fully-commented lines.
File name must be passed as first argument.
"""

import sys
lines = 0
with open(sys.argv[1]) as f:
    for line in f:
        line = line.strip()
        if line and not line.startswith('#'):
            lines += 1
    print lines
