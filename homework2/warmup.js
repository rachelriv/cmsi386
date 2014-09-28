exports.change = function(amount) {
    if (typeof amount !== 'number') {
        throw new TypeError('amount must be a number');
    } else if (amount < 0) {
        throw new RangeError('amount cannot be negative');
    }
    var QUARTER_VALUE = 25,
        DIME_VALUE = 10,
        NICKEL_VALUE = 5,
        quarters,
        dimes,
        nickels,
        pennies;

    quarters = Math.floor(amount / QUARTER_VALUE);
    amount %= QUARTER_VALUE;
    dimes = Math.floor(amount / DIME_VALUE);
    amount %= DIME_VALUE;
    nickels = Math.floor(amount / NICKEL_VALUE);
    pennies = amount % NICKEL_VALUE;
    return [quarters, dimes, nickels, pennies];
};

exports.stripQuotes = function(str) {
    return str.replace(/['"]/g, '');
};

exports.scramble = function(start) {
    // Fisher Yates shuffle from http://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle
    var shuffleArr = start.split('');
    for (var i = 0; i < start.length; i++) {
        var j = Math.floor(Math.random() * i);
        var shuffleI = shuffleArr[i];
        shuffleArr[i] = shuffleArr[j];
        shuffleArr[j] = shuffleI;
    }
    return shuffleArr.join('');
};

exports.powersOfTwo = function(limit, callback) {
    for (var x = 1; x <= limit; x *= 2) {
        callback(x);
    }
};

exports.prefixes = function(str, callback) {
    var strArr = str.split('');
    for (var i = 0; i <= strArr.length; i++) {
        callback(strArr.slice(0, i).join(''));
    }
};

exports.interleave = function(a, b) {
    var aLen = a.length,
        bLen = b.length,
        maxLen = Math.max(aLen, bLen),
        returnArr = [];
    for (var i = 0; i < maxLen; i++) {
        if (i < aLen) {
            returnArr.push(a[i]);
        }
        if (i < bLen) {
            returnArr.push(b[i]);
        }
    }
    return returnArr;
};

exports.stutter = function(arr) {
    return this.interleave(arr, arr);
};
