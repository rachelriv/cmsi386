# from http://nodejs.org/api/process.html#process_process_stdin
console.log new Date().getTime()
process.stdin.setEncoding 'utf8'

input = ''
process.stdin.on 'readable', ->
  input += process.stdin.read() ? ''

process.stdin.on 'end', ->
  wordCount = getWordCounts input
  printSorted wordCount
  console.log new Date().getTime()

getWordCounts = (string) ->
  words = string.toLowerCase().split(/[^a-z']+/)
  result = {}
  words.forEach (word) ->
    result[word] = (if result.hasOwnProperty(word) then result[word] + 1 else 1)
  result

printSorted = (wordCounts) ->
  sortedWords = Object.keys(wordCounts).sort()
  sortedWords.forEach (v, i) ->
    console.log v, wordCounts[v]
