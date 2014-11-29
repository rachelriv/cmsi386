var nextOdd = function() {
    var x = -1;
    return function() {return x += 2;};
}