var chai      = require('chai'),
    expect    = chai.expect
    sinon     = require('sinon'),
    sinonChai = require('sinon-chai'),
    warmup    = require('../warmup.js');

chai.use(sinonChai);


describe('warmup', function() {


  describe('#change', function() {

    context('when a positive integer amount is given', function() {
      it('returns an array with integer coin values', function() {
        expect(warmup.change(97)).to.eql([3, 2, 0, 2]);
        expect(warmup.change(8)).to.eql([0, 0, 1, 3]);
        expect(warmup.change(250)).to.eql([10, 0, 0, 0]);
      });
    });

    context('when 0 is given as the amount', function() {
      it('returns an array with all zeros', function() {
        expect(warmup.change(0)).to.eql([0, 0, 0, 0]);
      });
    });

    context('when a large number is given as the amount', function() {
      it('returns an array with integer coin values', function() {
        expect(warmup.change(2500000000001)).to.eql([100000000000, 0, 0, 1]);
      });
    });

    context('when a float is given as the amount', function() {
      it('returns an array with floats', function() {
        expect(warmup.change(33.25)).to.eql([1.0, 0.0, 1.0, 3.25]);
      });
    });

    context('when a negative amount is given', function() {
      it('throws a range error', function() {
        var changeWithNegative;
        changeWithNegative = function() {
          warmup.change(-4);
        };
        expect(changeWithNegative).to["throw"](RangeError);
      });
    });

    context('when a non-number is given as the amount', function() {
      it('raises a TypeError', function() {
        var changeWithAbc;
        changeWithAbc = function() {
          warmup.change('abc');
        };
        expect(changeWithAbc).to["throw"](TypeError);
      });
    });
  });


  describe('#stripQuotes', function() {

    context('when an empty string is provided', function() {
      it('returns an empty string', function() {
        expect(warmup.stripQuotes('')).to.equal('');
      });
    });

    context('when a string without quotes is provided', function() {
      it('returns a string identical to the original string', function() {
        var originalString;
        originalString = 'Hello, world';
        expect(warmup.stripQuotes(originalString)).to.equal(originalString);
      });
    });

    context('when a string with all quotes is provided', function() {
      it('returns an empty string', function() {
        expect(warmup.stripQuotes("\'\"\'")).to.equal('');
      });
    });

    context('when a string with quotes and other characters is provided', function() {
      it('returns a string with non-quote characters', function() {
        expect(warmup.stripQuotes('a\"\"\'\"\"\"z')).to.equal('az');
      });
    });


    describe('#scramble', function() {
      context('when a non-empty string is provided', function() {
        it('returns a scrambled string, preserving all characters', function() {
          var originalString, scrambledString, sortedOriginalLetters, sortedScrambledLetters;
          originalString = 'Hello, world';
          sortedOriginalLetters = originalString.split('').sort();
          scrambledString = warmup.scramble(originalString);
          sortedScrambledLetters = scrambledString.split('').sort();
          expect(sortedScrambledLetters).to.eql(sortedOriginalLetters);
        });
      });
    });


    describe('#powersOfTwo', function() {
      context('when a positive number is given', function() {
        it('yields powers of two, consuming values with a callback', function() {
          var callbackFor60, callbackFor63, callbackFor64, callbackFor70;

          callbackFor70 = sinon.spy();
          warmup.powersOfTwo(70, callbackFor70);
          expect(callbackFor70).to.have.callCount(7);
          expect(callbackFor70.args[0][0]).to.equal(1);
          expect(callbackFor70.args[1][0]).to.equal(2);
          expect(callbackFor70.args[2][0]).to.equal(4);
          expect(callbackFor70.args[3][0]).to.equal(8);
          expect(callbackFor70.args[4][0]).to.equal(16);
          expect(callbackFor70.args[5][0]).to.equal(32);
          expect(callbackFor70.args[6][0]).to.equal(64);

          callbackFor60 = sinon.spy();
          warmup.powersOfTwo(60, callbackFor60);
          expect(callbackFor60).to.have.callCount(6);
          expect(callbackFor60.args[0][0]).to.equal(1);
          expect(callbackFor60.args[1][0]).to.equal(2);
          expect(callbackFor60.args[2][0]).to.equal(4);
          expect(callbackFor60.args[3][0]).to.equal(8);
          expect(callbackFor60.args[4][0]).to.equal(16);
          expect(callbackFor60.args[5][0]).to.equal(32);

          callbackFor63 = sinon.spy();
          warmup.powersOfTwo(63, callbackFor63);
          expect(callbackFor63).to.have.callCount(6);
          expect(callbackFor63.args[0][0]).to.equal(1);
          expect(callbackFor63.args[1][0]).to.equal(2);
          expect(callbackFor63.args[2][0]).to.equal(4);
          expect(callbackFor63.args[3][0]).to.equal(8);
          expect(callbackFor63.args[4][0]).to.equal(16);
          expect(callbackFor63.args[5][0]).to.equal(32);

          callbackFor64 = sinon.spy();
          warmup.powersOfTwo(64, callbackFor64);
          expect(callbackFor64).to.have.callCount(7);
          expect(callbackFor64.args[0][0]).to.equal(1);
          expect(callbackFor64.args[1][0]).to.equal(2);
          expect(callbackFor64.args[2][0]).to.equal(4);
          expect(callbackFor64.args[3][0]).to.equal(8);
          expect(callbackFor64.args[4][0]).to.equal(16);
          expect(callbackFor64.args[5][0]).to.equal(32);
          expect(callbackFor64.args[6][0]).to.equal(64);
        });
      });

      context('when one is given', function() {
        it('consumes only the value one in the callback', function() {
          var callbackForOne;
          callbackForOne = sinon.spy();
          warmup.powersOfTwo(1, callbackForOne);
          expect(callbackForOne).to.have.been.called.once;
          expect(callbackForOne.args[0][0]).to.equal(1);
        });
      });

      context('when zero is given', function() {
        it('does not consume any values in a callback', function() {
          var callbackForZero;
          callbackForZero = sinon.spy();
          warmup.powersOfTwo(0, callbackForZero);
          expect(callbackForZero).to.not.have.been.called;
        });
      });

      context('when a negative number is given', function() {
        it('does not consume any values in a callback', function() {
          var callbackForNegative;
          callbackForNegative = sinon.spy();
          warmup.powersOfTwo(-10, callbackForNegative);
          expect(callbackForNegative).to.not.have.been.called;
        });
      });
    });


    describe('#prefixes', function() {

      context('when an empty string is given', function() {
        it('calls the callback with the empty string', function() {
          var callbackForEmptyString;
          callbackForEmptyString = sinon.spy();
          warmup.prefixes('', callbackForEmptyString);
          expect(callbackForEmptyString).to.have.been.called.once;
          expect(callbackForEmptyString.args[0][0]).to.equal('');
        });
      });

      context('when a string of length one is given', function() {
        it('calls the callback with the empty string and the character', function() {
          var callbackForOneChar;
          callbackForOneChar = sinon.spy();
          warmup.prefixes('a', callbackForOneChar);
          expect(callbackForOneChar).to.have.been.called.twice;
          expect(callbackForOneChar.args[0][0]).to.equal('');
          expect(callbackForOneChar.args[1][0]).to.equal('a');
        });
      });

      context('when a typical string is given', function() {
        it('yields successive prefixes, starting with the first zero-character prefix', function() {
          var callback;
          callback = sinon.spy();
          warmup.prefixes('brendan eich', callback);
          expect(callback).to.have.callCount(13);
          expect(callback.args[0][0]).to.equal('');
          expect(callback.args[1][0]).to.equal('b');
          expect(callback.args[2][0]).to.equal('br');
          expect(callback.args[3][0]).to.equal('bre');
          expect(callback.args[4][0]).to.equal('bren');
          expect(callback.args[5][0]).to.equal('brend');
          expect(callback.args[6][0]).to.equal('brenda');
          expect(callback.args[7][0]).to.equal('brendan');
          expect(callback.args[8][0]).to.equal('brendan ');
          expect(callback.args[9][0]).to.equal('brendan e');
          expect(callback.args[10][0]).to.equal('brendan ei');
          expect(callback.args[11][0]).to.equal('brendan eic');
          expect(callback.args[12][0]).to.equal('brendan eich');
        });
      });
    });


    describe('#interleave', function() {
      context('when two empty arrays are given', function() {
        it('returns an empty array', function() {
          expect(warmup.interleave([], [])).to.eql([]);
        });
      });

      context('when a non-empty array is interleaved with an empty array', function() {
        it('returns an array that is identical to the original non-empty array', function() {
          var a, b;
          a = [];
          b = [1];
          expect(warmup.interleave(a, b)).to.eql(b);
        });
      });

      context('when null/undefined values are in the array', function() {
        it('preserves the null/undefined values in the interleaving', function() {
          var a, b;
          a = [null, 1, 2];
          b = ['a', 'b', void 0];
          expect(warmup.interleave(a, b)).to.eql([null, 'a', 1, 'b', 2, void 0]);
        });
      });

      context('when an typical array is given', function() {
        it('interleaves the two arrays', function() {
          var a, b;
          a = [1];
          b = ['a', 'b', 'c', 'd'];
          expect(warmup.interleave(a, b)).to.eql([1, 'a', 'b', 'c', 'd']);
          a = ['a', 'b', 'c', 'd'];
          b = [1];
          expect(warmup.interleave(a, b)).to.eql(['a', 1, 'b', 'c', 'd']);
        });
      });
    });


    describe('#stutter', function() {
      context('when two empty arrays are given', function() {
        it('returns an empty array', function() {
          expect(warmup.stutter([])).to.eql([]);
        });
      });

      context('when hashes are given within the array', function() {
        it('stutters the array with the hashes unchanged', function() {
          expect(warmup.stutter([
            {
              x: 0
            }, 1
          ])).to.eql([
            {
              x: 0
            }, {
              x: 0
            }, 1, 1
          ]);
        });
      });
    });
  });
});
