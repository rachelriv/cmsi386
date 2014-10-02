# from http://nodejs.org/api/process.html#process_process_stdin

process.stdin.setEncoding 'utf8'

input = ''
process.stdin.on 'readable', ->
  input += process.stdin.read() ? ''

process.stdin.on 'end', ->
  wordCount = getWordCounts input
  printSorted wordCount

getWordCounts = (s) ->
  words = s.toLowerCase().split(/[^a-z']+/)
  result = {}
  words.forEach (w) ->
    result[w] = (if result.hasOwnProperty(w) then result[w] + 1 else 1)
    return

  result

printSorted = (wordCounts) ->
  Object.keys(wordCounts).sort().forEach (v, i) ->
    console.log v, wordCounts[v]

