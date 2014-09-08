#!/usr/bin/env python2
"""A module containing some of the warm up functions assigned for cmsi386."""

import random


def change(amount):
    """Return the smallest number of coins to make up a given amount.

    Return a tuple containing the smallest number of US quarters,
    nickels, and pennies that equal the given amount. Raises an
    exception if the amount given is not a postive number.
    """
    if amount < 0:
        raise ValueError('amount cannot be negative')
    quarters, rest = divmod(amount, 25)
    dimes, rest = divmod(rest, 10)
    nickels, pennies = divmod(rest, 5)
    return (quarters, dimes, nickels, pennies)


def strip_quotes(s):
    """Return a string like s but without apostrophes or double quotes."""
    return s.translate(None, "\"\'")


def scramble(s):
    """Return a random permutation of s."""
    return "".join(random.sample(s, len(s)))


def powers_of_two(n):
    """Generate powers of two from 1 upto and including n."""
    result = 1
    while result <= n:
        yield result
        result *= 2


def prefixes(s):
    """Generate successive prefixes of a string.

    Starts with the first prefix, which is zero characters long
    """
    for i in range(len(s)+1):
        yield s[0:i]


def interleave(a, b):
    """Return the interleaving of two sequences as a list.

    Idea for interleaving from cmsi386 lecture on 9-04-14.
    """
    return [y for x in zip(a, b) for y in x] + a[len(b):] + b[len(a):]


def stutter(l):
    """Return a list containing the elements of list l doubled up."""
    return interleave(l, l)
