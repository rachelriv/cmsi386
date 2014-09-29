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

  context 'when an empty string is provided', ->
    it 'returns an empty string', ->
      expect(warmup.stripQuotes '').to.equal ''

  context 'when a string without quotes is provided', ->
    it 'returns a string identical to the original string', ->
      originalString = 'Hello, world'
      expect(warmup.stripQuotes originalString).to.equal originalString

  context 'when a string with all quotes is provided', ->
    it 'returns an empty string', ->
      expect(warmup.stripQuotes "\'\"\'").to.equal ''

  context 'when a string with quotes and other characters is provided', ->
    it 'returns a string with non-quote characters', ->
      expect(warmup.stripQuotes 'a\"\"\'\"\"\"z').to.equal 'az'


  describe '#scramble', ->

    context 'when a non-empty string is provided', ->
      it 'returns a scrambled string, preserving all characters', ->
        originalString = 'Hello, world'
        sortedOriginalLetters = originalString.split('').sort()
        scrambledString = warmup.scramble originalString
        sortedScrambledLetters = scrambledString.split('').sort()

        expect(sortedScrambledLetters).to.eql sortedOriginalLetters


  describe '#powersOfTwo', ->

    context 'when a positive number is given', ->
      it 'yields powers of two, consuming values with a callback', ->
        resultFor70 = []
        warmup.powersOfTwo 70, (p) -> resultFor70.push(p)
        expect(resultFor70).to.eql [1, 2, 4, 8, 16, 32, 64]

        resultFor60 = []
        warmup.powersOfTwo 60, (p) -> resultFor60.push(p)
        expect(resultFor60).to.eql [1, 2, 4, 8, 16, 32]

        resultFor63 = []
        warmup.powersOfTwo 63, (p) -> resultFor63.push(p)
        expect(resultFor63).to.eql [1, 2, 4, 8, 16, 32]

        resultFor64 = []
        warmup.powersOfTwo 64, (p) -> resultFor64.push(p)
        expect(resultFor64).to.eql [1, 2, 4, 8, 16, 32, 64]

    context 'when zero is given', ->
      it 'does not return anything in the callback', ->
        resultForZero = []
        warmup.powersOfTwo 0, (p) -> resultForZero.push(p)
        expect(resultForZero).to.eql []

    context 'when one is given', ->
      it 'returns one in the callback', ->
        resultForOne = []
        warmup.powersOfTwo 1, (p) -> resultForOne.push(p)
        expect(resultForOne).to.eql [1]

    context 'when a negative number is given', ->
      it 'does not return anything in the callback', ->
        resultForNegative = []
        warmup.powersOfTwo -6, (p) -> resultForNegative.push(p)
        expect(resultForNegative).to.eql []



# vim: ts=2:sw=2
