# from http://nodejs.org/api/process.html#process_process_stdin
fs = require 'fs'

if process.argv.length isnt 3 or not fs.existsSync process.argv[2]
  console.log 'Please provide exactly one argument containing a valid text file'
  process.exit 1

fs.readFile process.argv[2], {encoding: 'UTF-8'},  (err, res) ->
  throw err if err
  lineCount = 0
  res.split(/\r?\n/g).forEach (line) ->
    trimmedLine = line.trim()
    lineCount++ if trimmedLine and not trimmedLine.match /^#/
  console.log lineCount
