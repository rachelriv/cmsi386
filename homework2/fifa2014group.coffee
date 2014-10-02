request = require 'request'


areValidArgs = (args) ->
  args.length is 3 and args[2].match('^[A-H]$')

getRequestOpts = (group) ->
  method: 'GET'
  uri: 'http://worldcup.kimonolabs.com/api/teams'
  qs:
    apikey: 'KERbxAUfDYovbQnn9pR3pbLWEMRp47AQ'
    group: group
    fields: 'name,wins,losses,draws,goalsDiff'
    sort: 'groupRank'

# http://dev.enekoalonso.com/2010/07/20
# /little-tricks-string-padding-in-javascript/
rightPad = (str, len) ->
  emptySpaces = Array(len).join(' ')
  (str + emptySpaces).slice(0, len)

printFormatted = (teams) ->
  defaultPadding = 19
  console.log "#{rightPad 'Team', defaultPadding}W  D  L"
  teams.forEach (team) ->
    paddingAmount = Math.max team.name.length, defaultPadding
    console.log "#{rightPad team.name, paddingAmount}\
                 #{team.wins}  #{team.draws}  #{team.losses}"


unless areValidArgs process.argv
  console.log '''Please provide exactly one capital letter\
                  representing a valid FIFA 2014 group'''
  process.exit 1

group = process.argv[2]
requestOpts = getRequestOpts group

request requestOpts, (err, res, body) ->
  teams = JSON.parse body
  printFormatted teams

