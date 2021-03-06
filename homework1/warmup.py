#!/usr/bin/env python2
"""A module containing some of the warm up functions assigned for cmsi386."""

import random


def change(amount):
    """Return the smallest number of coins to make up a given amount.

    Return a tuple containing the smallest number of US quarters,
    nickels, and pennies that equal the given amount. Raises an
    exception if the amount given is not a postive number.
    """
    quarter_value, dime_value, nickel_value = 25, 10, 5
    if amount < 0:
        raise ValueError('amount cannot be negative')
    quarters, rest = divmod(amount, quarter_value)
    dimes, rest = divmod(rest, dime_value)
    nickels, pennies = divmod(rest, nickel_value)
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
    return (s[0:i] for i in range(len(s)+1))


def interleave(a, b):
    """Return the interleaving of two sequences as a list.

    http://stackoverflow.com/questions/1198777/double-iteration-in-list-comprehension
    """
    return [item for group in zip(a, b) for item in group] + a[len(b):] + b[len(a):]


def stutter(a):
    """Return a list containing the elements of list a doubled up."""
    return interleave(a, a)
