wordcount = require '../wordcount.coffee'
chai = require 'chai'
expect = chai.expect
sinon = require 'sinon'
sinonChai = require 'sinon-chai'
chai.use sinonChai

describe 'wordcount', ->
  beforeEach ->
    process = stdin: sinon.stub()
  context 'when words are inputted to stdin', ->
    it 'prints the count of all words to stdout', ->
       
