wordcount = require '../wordcount.coffee'
path = require 'path'
chai = require 'chai'
expect = chai.expect
spawn = require('child_process').spawn

describe 'wordcount', ->

  describe '#getWords', ->

  	context 'when a string is provided', ->
  	  it 'splits the string into an array of alphabetized getWords
  	     (a word is a contiguous sequence of ASCII letters & apostrophes) ', ->
        str1 =  "Long, long agø they'd found \
                an int -- and a long. \
                And a string!"
        expect(wordcount.getWords str1)
          .to.eql ['a', 'a', 'ag', 'an', 'and', 'and', 'found',
                   'int', 'long', 'long', 'long', 'string', 'they\'d']

        str2 = "QQQ A abc\na  a\tHA:qQq"
        expect(wordcount.getWords str2)
          .to.eql ['a', 'a', 'a', 'abc', 'ha', 'qqq', 'qqq' ]


  describe '#printWordCount', ->

  	context 'given an array of alphabetically sorted words', ->
  	  it 'prints each word with its count in sorted order', ->
  	    arr1 = ['a', 'a', 'ag', 'an', 'and',
  	     'and', 'found', 'int', 'long', 'long',
  	      'long', 'string', 'they\'d' ]
        process.stdout.pipe(writer)

        # wordcount.printWordCount arr1
        # console.log output

        # arr2 = ['a', 'a', 'a', 'abc', 'ha', 'qqq', 'qqq' ]
