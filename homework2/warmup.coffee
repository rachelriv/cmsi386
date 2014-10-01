divmod = (x, y) ->
  [x // y, x %% y]

exports.change = (cents) ->
  throw new TypeError 'amount must be a number' if typeof cents isnt 'number'
  throw new RangeError 'amount cannot be negative' if cents < 0
  [QUARTER_VALUE, DIME_VALUE, NICKEL_VALUE] = [25, 10, 5]
  [quarters, cents] = divmod cents, QUARTER_VALUE
  [dimes, cents] = divmod cents, DIME_VALUE
  [nickels, pennies] = divmod cents, NICKEL_VALUE
  [quarters, dimes, nickels, pennies]

exports.stripQuotes = (str) ->
  str.replace /['"]/g, ''

exports.scramble = (start) ->
  shuffle = start.split ''
  for char, index in shuffle
    j = Math.floor (Math.random() * index)
    [shuffle[index], shuffle[j]] = [shuffle[j], shuffle[index]]
  shuffle.join ''

exports.powersOfTwo = (limit, callback) ->
  callback i for i in [1..limit] by i unless limit < 0

exports.prefixes = (string, callback) ->
  callback string.substring(0,i) for i in [0..string.length]

exports.interleave = (a, b) ->
  result = []
  for index in [0..Math.max a.length, b.length]
    if index < a.length
      result.push a[index]
    if index < b.length
      result.push b[index]
  result

exports.stutter = (a) =>
  @interleave a, a
