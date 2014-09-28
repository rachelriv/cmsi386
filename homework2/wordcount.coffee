# from http://nodejs.org/api/process.html#process_process_stdin

process.stdin.setEncoding 'utf8'

input = ''
process.stdin.on 'readable', ->
    input += process.stdin.read()? or ''

process.stdin.on 'end', ->
    wordCounts = getWordCounts input
    printSorted wordCounts

getWordCounts = (str) ->
   words = str.toLowerCase().split /[^a-z']+/
   for word in words
