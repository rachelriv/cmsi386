library warmup;

import 'dart:collection';
import 'dart:math';

List<num> change(num amount) {
  if (amount < 0) {
    throw new RangeError('amount cannot be negative');
  }
  const QUARTER_VAL = 25, DIME_VAL = 10, NICKEL_VAL = 5;
  var quarters = amount ~/ QUARTER_VAL;
  amount = amount.remainder(QUARTER_VAL);
  var dimes = amount ~/ DIME_VAL;
  amount = amount.remainder(DIME_VAL);
  var nickels = amount ~/ NICKEL_VAL;
  var pennies = amount.remainder(NICKEL_VAL);
  return [quarters, dimes, nickels, pennies];
}

String stripQuotes(String begin) => begin.replaceAll(new RegExp("['\"]"), '');

String scramble(String begin) => (begin.split('')..shuffle()).join();

class _PowTwoIterator implements Iterator<int> {
  final int _itLimit;
  int currentPos;

  _PowTwoIterator(int limit): _itLimit = limit, currentPos = 0;

  bool moveNext() {
    currentPos *= 2;
    // Iterators in dart call moveNext before finding the first value, so we need to
    // start it off at the -1th position, and when moveNext is called, move it into the
    // first position. See comment above powersOfTwo.
    if (currentPos == 0) {
      currentPos = 1;
    }
    if (currentPos > _itLimit) {
      return false;
    }

    return true;
  }

  int get current => currentPos;
}

class _PowTwoIterable extends IterableBase<int> {
  int _itLimit;
  _PowTwoIterable(int limit) {
    _itLimit = limit;
  }

  Iterator<int> get iterator => new _PowTwoIterator(_itLimit);
}
// GODDAMMIT DART!!!!!!!
Iterable<int> powersOfTwo(int limit) {
  return new _PowTwoIterable(limit);
}

Iterable<String> prefixes(String toPrefix) =>
    new Iterable.generate(toPrefix.length, (index) => toPrefix.substring(0, index));

List interleave(List listA, List listB) {
  var maxLength = max(listA.length, listB.length);
  var returnList = [];
  for (var i = 0; i < maxLength; i++) {
    if (listA.length < maxLength) {
      returnList.add(listA[i]);
    }
    if (listB.length < maxLength) {
      returnList.add(listB[i]);
    }
  }
}

List stutter(List toStutter) => interleave(toStutter, toStutter);
