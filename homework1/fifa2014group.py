#!/usr/bin/env python2
import re
import sys
import requests
from operator import itemgetter


def get_all_teams(group):
    """Get all teams within a specified fifa2014 group."""
    base_url = 'http://worldcup.kimonolabs.com/api/teams'
    url = (base_url + '?apikey={key}&group={group}&sort={sort}'
           .format(group=group,
                   key='KERbxAUfDYovbQnn9pR3pbLWEMRp47AQ',
                   sort='groupRank'))
    r = requests.get(url)
    return r.json()


def display_teams(teams):
    """Display team information in a table."""
    # https://wiki.python.org/moin/HowTo/Sorting
    print 'Name               W  D  L'
    for team in teams:
        print '{name:<19}{wins}  {draws}  {losses}'.format(**team)

if __name__ == "__main__":
    if len(sys.argv) != 2 or sys.argv[1] not in list('ABCDEFGH'):
        print "Need just one commandline argument, A...H"
        sys.exit(1)
    else:
        group = sys.argv[1]
        teams = get_all_teams(group)
        display_teams(teams)
