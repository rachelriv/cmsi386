#!/usr/bin/env python2
# found file opening approach here: http://stackoverflow.com/questions/845058/
"""A script reporting the number of lines in a file.

The script only counts non-blank, fully-commented lines.
File name must be passed as first argument.
"""

import sys
with open(sys.argv[1]) as f:
    print reduce(lambda x, y: x+1
                 if y.strip() and not y.strip().startswith('#')
                 else x, f, 0)
