module.exports = {
    change: function(startingValue) {
        if (startingValue < 0) {
            throw new RangeError('amount cannot be negative');
        }
        var changeArr = [];
        var quarterVal = 25,
            dimeVal = 10,
            nickelVal = 5;
        value = startingValue;
        changeArr.push(Math.floor(value / quarterVal));
        value %= quarterVal;
        changeArr.push(Math.floor(value / dimeVal));
        value %= dimeVal;
        changeArr.push(Math.floor(value / nickelVal));
        changeArr.push(value % nickelVal);
        console.log(changeArr);
        return changeArr;
    },

    stripQuotes: function(start) {
        var re = /['"]/;
        return start.replace(/['"]/, '');
    },

    scramble: function(start) {
        // Fisher Yates shuffle from http://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle
        var shuffleArr = start.split('');
        for(var i = 0; i < start.length; i++) {
            j = Math.floor(Math.random() * i);
            var shuffleI = shuffleArr[i];
            shuffleArr[i] = shuffleArr[j];
            shuffleArr[j] = shuffleI;
        }
        return shuffleArr.join('');
    },

    powersOfTwo: function(limit, callback) {
        var num = 1;
        while(num <= limit) {
            callback(num);
            num*=2;
        }
    },

    prefixes: function(str, callback) {
        var strArr = str.split('');
        for(var i = 0; i < strArr.length; i++) {
            callback(strArr.slice(0, i).join(''));
        }
    },

    interleave: function(arr1, arr2) {
        // TODO: This is really ugly. Fix.
        var onArr1 = true;
        var returnArr = [];
        shortestLength = Math.min(arr1.length, arr2.length);
        for(var i = 0; i < shortestLength * 2; i++) {
            var index = Math.floor(i/2);
            returnArr.push(onArr1 ? arr1[index] : arr2[index]);
            onArr1 = !onArr1;
        }
        returnArr.concat(arr1.slice(shortestLength));
        returnArr.concat(arr2.slice(shortestLength));
        return returnArr;
    },

    stutter: function(arr) {
        return interleave(arr, arr);
    }
};
