if not process.argv[2]? or process.argv.length isnt 3 or not fs.existsSync process.argv[2]
    console.log 'Please provide exactly 1 argument for a valid file'
    process.exit 1

fs.readFile process.argv[2], (err, data) =>
    if err
        console.log 'Unexpected error occured. Please try again'
        process.exit 1
    for line in data.split /\r?\n/g
        # count words
