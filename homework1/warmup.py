"""A module containing some of the warm up functions assigned for cmsi386"""

import random


def change(amount):
    """Returns a tuple containing the smallest number of US quarters,
    nickels, and pennies that equal the given amount. Raises an
    exception if the amount is not a postive number."""
    if amount < 0:
        raise ValueError('amount cannot be negative')
    quarters, rest = divmod(amount, 25)
    dimes, rest = divmod(rest, 10)
    nickels, pennies = divmod(rest, 5)
    return (quarters, dimes, nickels, pennies)


def strip_quotes(s):
    """Return string like s but with all apostrophes
    and double quotes removed."""
    return s.translate(None, "\"\'")


def scramble(s):
    """Return a random permutation of s"""
    return "".join(random.sample(s, len(s)))


def powers_of_two(n):
    """Generate powers of two from 1 upto n"""
    result = 1
    while result <= n:
        yield result
        result *= 2


def prefixes(s):
    """Generates successive prefixes of a string, starting
    with the first prefix (0 characters long)"""
    for i in range(len(s)+1):
        yield s[0:i]


def interleave(a, b):
    """Return the interleaving of two sequences as a list."""
    return [y for x in zip(a, b) for y in x] + a[len(b):] + b[len(a):]


def stutter(a):
    """Return a list containing the elements of a doubled up. Example:
    stutter([3, [4], 'x']) ==> [3, 3, [4], [4], 'x', 'x']
    """
    return interleave(a, a)
