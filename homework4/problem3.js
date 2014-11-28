var arrayMinimum = function (array) {

    var findMin = function (a, m) {
        return a.length === 0 ? m : findMin(a.slice(1), m < a[0] ? m : a[0])
    }

    return findMin(array, Infinity);

}