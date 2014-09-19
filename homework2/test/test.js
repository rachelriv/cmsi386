var should = require('chai').should();
// TODO: Add 'it' methods to describe things better
describe('warmup.js', function(){
    var warmup = require('../warmup.js');
    describe('change', function(){
        it('should return American change for a given cent amount, or throw a range error if negative', function(){
            warmup.change(96).should.eql([3, 2, 0, 1]);
            warmup.change(8).should.eql([0, 0, 1, 3]);
            (function(){warmup.change(-9);}).should.throw(RangeError, 'amount cannot be negative');
            warmup.change(33.25).should.eql([1, 0, 1, 3.25]);
        });
    });

    describe('stripQuotes', function(){
        it('should remove all quotes from a string', function(){
            warmup.stripQuotes("a\"\"\'\"\"\"\"z").should.equal('az');
        });
    });

    describe('scramble', function(){
        it('should scramble the word', function(){
            warmup.scramble('Hello, World!').split('').sort().should.eql('Hello, World!'.split('').sort());
        });
    });

    describe('powersOfTwo', function(){
        it('should call a callback for all powers of two less than a given number asynchrnously', function(){
            var po2Arr = [];
            warmup.powersOfTwo(70, function(p){
                po2Arr.push(p);
            });
            po2Arr.should.eql([1, 2, 4, 8, 16, 32, 64]);
        });
    });

    describe('prefixes', function(){
        it('should call a callback for all successive prefixes of a string', function(){
            var preArr = [];
            warmup.prefixes('brendan', function(p){
                preArr.push(p);
            });
            preArr.should.eql(['', 'b', 'br', 'bre', 'bren', 'brend', 'brenda', 'brendan']);
        });
    });

    describe('interleave', function(){
        it('should interleave two arrays', function(){
            warmup.interleave(['a', 'b'], [1, 2, true, null]).should.eql(["a", 1, "b", 2, true, null]);
            warmup.interleave([7, 3, 'dog'], [false]).should.eql([7, false, 3, 'dog']);
        });
    });

    describe('stutter', function(){
        it('should double every element in the array', function(){
            warmup.stutter([5,'dog',[3],9]).should.eql([5,5,'dog','dog',[3],[3],9,9]);
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
