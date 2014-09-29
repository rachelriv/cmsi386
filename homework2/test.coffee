warmup = require './warmup'
chai = require 'chai'

describe '#change', ->
  context 'when blah', ->
    it 'blah', ->
      expect(warmup.change 97).to.eql [3,2,0,2]