wordcount = require '../wordcount.coffee'
chai = require 'chai'
expect = chai.expect
exec = require('child_process').exec

describe 'wordcount', ->
  context 'when words are inputted to stdin', ->
    it 'prints the count of all words to stdout', ->

      childProcess.stdin = "abcdef"
      wordcount

