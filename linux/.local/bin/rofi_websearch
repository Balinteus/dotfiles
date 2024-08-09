#!/usr/bin/env bash

echo -e "\0prompt\x1fWebsearch"

if [[ ! -z "$@" ]]; then
 coproc ( firefox --new-tab --search "$@"  > /dev/null  2>&1 )
fi
