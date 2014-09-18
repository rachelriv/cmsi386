var should = require('chai').should();
// TODO: Add 'it' methods to describe things better
describe('warmup.js', function(){
    var warmup = require('../warmup.js');
    describe('change', function(){
        it('should return American change for a given cent amount, or throw a range error if negative', function(){
            change(96).should.equal([3, 2, 0, 1]);
            change(8).should.equal([0, 0, 1, 3]);
            should.throw(change(-9), RangeError, 'amount cannot be negative');
            change(33.25).should.equal([1, 0, 1, 3.25]);
        });
    });

    describe('stripQuotes', function(){
        it('should remove all quotes from a string', function(){
            stripQuotes("a\"\"\'\"\"\"\"z").should.equal('az');
        });
    });

    describe('scramble', function(){
        // NFI how to do this...
    });

    describe('powersOfTwo', function(){
        it('should call a callback for all powers of two less than a given number asynchrnously', function(){
            var po2Arr = [];
            powersOfTwo(70, function(p){
                po2Arr.push(p);
            });
            po2Arr.should.equal([1, 2, 4, 8, 16, 32, 64]);
        });
    });

    describe('prefixes', function(){
        it('should call a callback for all successive prefixes of a string', function(){
            var preArr = [];
            prefixes('brendan', function(p){
                preArr.push(p);
            });
            preArr.should.equal(['b', 'br', 'bre', 'bren', 'brend', 'brenda', 'brendan']);
        });
    });

    describe('interleave', function(){
        it('should interleave two arrays', function(){
            interleave(['a', 'b'], [1, 2, true, null]).should.equal(["a", 1, "b", 2, true, null]);
            interleave([7, 3, 'dog'], [false]).should.equal([7, false, 3, 'dog']);
        });
    });

    describe('stutter', function(){
        it('should double every element in the array', function(){
            stutter([5,'dog',[3],9]).should.equal([5,5,'dog','dog',[3],[3],9,9]);
        });
    });
});

describe('lines.js', function(){
    var lines = require('../lines.js');
});

describe('wordcount.js', function(){
    var wordcount = require('../wordcount.js');
});

describe('fifa2014group.js', function(){
    var fifa = require('../fifa2014group.js');
});
