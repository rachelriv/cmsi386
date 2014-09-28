/* Reports the number of non-blank, non-fully-commented lines in the file
*  named by the first argument.
*  http://stackoverflow.com/questions/12735778/for-in-and-hasownproperty
*  https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Array_comprehensions
*/
var getWordCounts = function (s) {
    var words, result;
    words = s.toLowerCase().split(/[^a-z\']+/);
    result = {};
    words.forEach(function (w) {result[w] = result.hasOwnProperty(w) ? result[w] + 1 : 1})
    return result;
}

var printSorted = function(wordCounts) {
    Object.keys(wordCounts)
        .sort()
        .forEach(function(v, i) {
            console.log(v, wordCounts[v])
        })
}

process.stdin.setEncoding('utf8');
var input = "";
process.stdin.on('readable', function() {
    var chunk = process.stdin.read();
    if (chunk !== null) {
        input += chunk.toString()
    }
})
process.stdin.on('end', function(){
    wordCounts = getWordCounts(input);
    printSorted(wordCounts);
})