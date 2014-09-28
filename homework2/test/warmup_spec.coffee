warmup = require '../warmup.coffee'
expect = require('chai').expect


describe '#change', ->

  context 'when a positive integer amount is given', ->
    it 'returns an array with integer coin values', ->
      expect(warmup.change 97).to.eql [3, 2, 0, 2]
      expect(warmup.change 8).to.eql [0, 0, 1, 3]
      expect(warmup.change 250).to.eql [10, 0, 0, 0]

  context 'when 0 is given as the amount', ->
    it 'returns an array with all zeros', ->
      expect(warmup.change 0).to.eql [0, 0, 0, 0]

  context 'when a large number is given as the amount', ->
    it 'returns an array with integer coin values', ->
      expect(warmup.change 2500000000001)
        .to.eql [100000000000, 0, 0, 1]

  context 'when a float is given as the amount', ->
    it 'returns an array with floats', ->
      expect(warmup.change 33.25)
        .to.eql [1.0, 0.0, 1.0, 3.25]

  context 'when a negative amount is given', ->
    it 'throws a range error', ->
      changeWithNegative = -> warmup.change -4
      expect(changeWithNegative).to.throw RangeError
  
  context 'when a non-number is given as the amount', ->
    it 'raises a TypeError', ->
      changeWithAbc = -> warmup.change 'abc'
      expect(changeWithAbc).to.throw TypeError
  

describe '#stripQuotes', ->

# vim: ts=2:sw=2
