#!/usr/bin/env python2
import re
import sys
import requests
from operator import itemgetter


def getAllTeams(group):
    base_url = 'http://worldcup.kimonolabs.com/api/teams'
    req_string = (base_url + '?apikey={key}&group={group}&fields={fields}'
                  .format(group=group,
                          key='KERbxAUfDYovbQnn9pR3pbLWEMRp47AQ',
                          fields='name,wins,losses,draws,goalsDiff'))
    r = requests.get(req_string)
    return r.json()


def displayTeams(teams):
    # https://wiki.python.org/moin/HowTo/Sorting
    sorted_teams = sorted(teams, cmp=comparator)
    print 'Name             W  D  L'
    for team in sorted_teams:
        print '{name:<17}{wins}  {draws}  {losses}'.format(**team)


def comparator(key1, key2):
    if key1['wins'] != key2['wins']:
        return -cmp(key1['wins'], key2['wins'])
    elif key1['draws'] != key2['draws']:
        return -cmp(key1['draws'], key2['draws'])
    else:
        return cmp(key1['goalsDiff'], key2['goalsDiff'])

if __name__ == "__main__":
    if len(sys.argv) == 1 or re.match('^[^A-H]$', sys.argv[1]):
        print "Need just one commandline argument, A...H"
    else:
        group = sys.argv[1]
        teams = getAllTeams(group)
        displayTeams(teams)
