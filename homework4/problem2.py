#!/usr/bin/env python2
import re

def a(string):
    return re.match(r'^"[^\^]*"$', string) is not None

def b(string):
    return re.match(r'^\(\*[^\*\)]*\*\)$', string) is not None

def c(string):
    return re.match(r'[-]?(0|[1-9][0-9]*)(\.[0-9]+)?([eE][+-]?[0-9]+)?') is not None

def d(string):
    return re.match(r'^(read|red|real)$') is None
