# from http://nodejs.org/api/process.html#process_process_stdin

process.stdin.setEncoding 'utf8'

input = ''
process.stdin.on 'readable', ->
  input += process.stdin.read() ? ''
  console.log input

process.stdin.on 'end', ->
  printSorted input

printSorted = (str) ->
  words = str.toLowerCase().split /[^a-z']+/
  words.sort()
  words = words.filter (word) -> word.trim().length > 0
  currentWord = words[0]
  wordCount = 0
  for word in words
    if word isnt currentWord
      console.log currentWord + ' ' + wordCount
      currentWord = word
      wordCount = 0
    wordCount++


