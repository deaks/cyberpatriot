#!/bin/bash
TURL='http://<scoring server URL>'
BURL='http://<scoring server base URL>/'
TEAM_IDs=( '09-' )
TEAM_ENTRY_PREFIX='clickable.*team'

OUT='team.html'

filter=''
for team_id in ${TEAM_IDs[@]}; do
  filter="${filter:-}${filter:+ }/${TEAM_ENTRY_PREFIX}.*${team_id}/{print;next}"
done
# skip other team entries, leave all other lines
filter="${filter:-}${filter:+ }/${TEAM_ENTRY_PREFIX}/{next}"
filter="${filter:-}${filter:+ }1"
wget -O - -B ${BURL} ${TURL} \
    | awk "${filter}" \
    | sed -e "s#<head>#<head><base href='${BURL}'>#" \
    >|"${OUT}"
