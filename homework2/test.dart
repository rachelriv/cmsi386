import 'package:unittest/unittest.dart';
import 'warmup.dart';
import 'dart:io';
import 'dart:convert';

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
    test('works for all possible length relationships', () {
      expect(interleave([], []), equals([]));
      expect(interleave([1], []), equals([1]));
      expect(interleave([], [1]), equals([1]));
      expect(interleave([1], [1]), equals([1, 1]));
      expect(interleave([null], [null]), equals([null, null]));
      expect(interleave([null, null], [0]), equals([null, 0, null]));
      expect(interleave([0], [null, null]), equals([0, null, null]));
      expect(interleave([1], ['a', 'b', 'c', 'd']), equals([1, 'a', 'b', 'c', 'd']));
      expect(interleave(['a', 'b', 'c', 'd'], [1]), equals(['a', 1, 'b', 'c', 'd']));
    });
  });

  group('stutter', () {
    test('works', () {
      expect(stutter([]), equals([]));
      expect(stutter([true]), equals([true, true]));
      expect(stutter([null]), equals([null, null]));
      expect(stutter([2, 'x', 5.5]), equals([2, 2, 'x', 'x', 5.5, 5.5 ]));
      expect(stutter([2, [3]]), equals([2, 2, [3], [3]]));
      expect(stutter([[[[[[null]]]]]]), equals([[[[[[null]]]]], [[[[[null]]]]]]));
      expect(stutter([{'x': 0}, 1]), equals([{'x': 0}, {'x': 0}, 1, 1]));
    });
  });

  group('lines', () {
    // Dart handles closing the file handles internally if there's an exception.
    File tempFile;
    setUp(() {
      var fileContents = '''
      // A file
      one

          two
            // yep, commented
      //////

      three
        F O U R
      ''';
      var tempDir = Directory.systemTemp;
      return new File('${tempDir.path}/lines.txt').writeAsString(fileContents)
      .then((file) {
        tempFile = file;
      });
    });

    tearDown(() {
      return tempFile.delete();
    });

    test('reads from a file and reports correct line count', () {
      return Process.run('dart', ['lines.dart', tempFile.path]).then((ProcessResult results) {
        print(results.stderr);
        expect(results.stdout, matches(r'4\r?\n'));
      });
    });

    group('wordcount', () {
      var story;
      setUp() {
        story = '''Long, long agø they'd found
          an int -- and a long.
        And a string!''';
      }

      test('reads from stdin and reports correct word count', () {
        return Process.start('dart', ['wordcount.dart']).then((Process process) {
          process.stdin.write(story);
          print(process.stderr);
          var matchPattern = r"^a 2\r?\nag 1\r?\nan 1\r?\nand 2\r?\nfound 1\r?\nint 1\r?\nlong 3\r?\nstring 1\r?\nthey'd 1$";
          UTF8.decodeStream(stdout).then((String story) {
            expect(story, matches(new RegExp(matchPattern)));
          });
        });
      });
    });
  });

}