1) We can hide data in a Node module by not exporting it. I think that we could easily use a module to implement a queue.
```javascript
var data = []
module.exports = {
    add: function(x) {data.push(x);},
    remove: function() {return data.shift();}
}
```
However, the code given in the question actually defines a data type for queues. I'm not sure how we would implement such a thing in Node.
\\TODO ask Dr. Toal about this one