# from http://nodejs.org/api/process.html#process_process_stdin

process.stdin.setEncoding 'utf8'

process.stdin.on 'readable', () =>
    chunk = process.stdin.read()
    for line in chunk.split /\r?\n/g
        # count lines
