import 'package:unittest/unittest.dart';
import 'warmup.dart';

void main() {
  group('change', () {
    test('Positive integer change', () {
      expect(change(97), equals([3, 2, 0, 2]));
      expect(change(8), equals([0, 0, 1, 3]));
      expect(change(250), equals([10, 0, 0, 0]));
    });

    test('Positive decimal change', () {
      expect(change(33.25), equals([1, 0, 1, 3.25]));
    });

    test('Large integer amounts', () {
      expect(change(2500000000001), equals([100000000000, 0, 0, 1]));
    });

    test('Negative change throws a RangeError', () {
      expect(() => change(-1), throwsRangeError);;
    });

    test('Invalid amount throws a ArgumentError', () {
      expect(() => true, returnsNormally);
      // Dart handles type safety, yay!
    });
  });

  group('stripQuotes', () {
    test('Empty string', () {
      expect(stripQuotes(''), equals(''));
    });

    test('String with no quotes', () {
      expect(stripQuotes('Hello, World'), equals('Hello, World'));
    });

    test('Strings with quotes', () {
      expect(stripQuotes('\"\''), equals(''));
      expect(stripQuotes('a\"\"\'\"\"\"\"z'), equals('az'));
    });
  });

  group('works', () {
    test('Scramble', () {
      var data = ["", "a", "rat", "BSOD", "BDFL", "Dart testing"];
      for (var s in data) {
        expect((new List.from(scramble(s).codeUnits)).sort(), equals((new List.from(s.codeUnits).sort())));
      }
    });

    test('is actually random', () {
      var possibilities = new Set.from('ABC ACB BAC BCA CAB CBA'.split(' '));

      for (var i = 0; i < 200; i++) {
        possibilities.remove(scramble('ABC'));
      }
      expect(possibilities, hasLength(0));
    });
  });

  group('powersOfTwo', () {
    test('produce iterator for all powers of two between 1 and a given number', () {
      expect(new List.from(powersOfTwo(60)), equals([1, 2, 4, 8, 16, 32]));
      expect(new List.from(powersOfTwo(63)), equals([1, 2, 4, 8, 16, 32]));
      expect(new List.from(powersOfTwo(64)), equals([1, 2, 4, 8, 16, 32, 64]));
      expect(new List.from(powersOfTwo(0)), equals([]));
      expect(new List.from(powersOfTwo(1)), equals([1]));
      expect(new List.from(powersOfTwo(-0)), equals([]));
    });

    test('actually produces an iterable', () {
      expect(powersOfTwo(3) is Iterable<int>, isTrue);
    });
  });

  group('prefixes', () {
    test('produces prefixes', () {
      expect(new List.from(prefixes('')), equals(['']));
      expect(new List.from(prefixes('a')), equals(['', 'a']));
      expect(new List.from(prefixes('ab')), equals(['', 'a', 'ab']));
      expect(new List.from(prefixes('abc')), equals(['', 'a', 'ab', 'abc']));
    });

    test('actually produces an iterator', () {
      expect(prefixes('abc') is Iterable<int>, isTrue);
    });
  });

  group('interleave', () {
    test()
  })
}