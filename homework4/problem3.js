var arrayMinimum = function (array) {

    var findMin = function (a, m) {
        if (a.length === 0){
            return m;
        } else {
            return findMin(a.slice(1), m < a[0] ? m : a[0]);
        }
    }

    return findMin(array, Infinity);

}