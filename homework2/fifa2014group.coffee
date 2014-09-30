http = require 'http'
if process.argv.length isnt 3 or not process.argv[2].match("^[A-H]$")
  console.log 'Please provide exactly one capital letter representing a valid FIFA 2014 group'
  process.exit 1

console.log "Team               W  D  L"

basePath = '/api/teams'
key = 'KERbxAUfDYovbQnn9pR3pbLWEMRp47AQ'
fields = 'name,wins,losses,draws,goalsDiff'
group = process.argv[2]
reqOptions =
  hostname: 'worldcup.kimonolabs.com'
  path: "#{basePath}?apikey=#{key}&group=#{group}&fields=#{fields}&sort=groupRank"

req = http.request reqOptions, (res) ->
  res.setEncoding 'utf8'
  res.on 'data', (data) ->
    teams = JSON.parse data
    teams.forEach (team) ->
      pad = 19 - team.name.length
      pad = 0 if pad < 0
      console.log "#{team.name}#{Array(pad).join(' ')} #{team.wins}  #{team.draws}  #{team.losses}"

req.end()