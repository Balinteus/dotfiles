#!/bin/sh

DZEN2_PID=$(pgrep dzen2)

if [ "${DZEN2_PID}" = "" ] ; then
  sh $HOME/.dotfiles/bin/dzen2_status.sh
else
  kill $DZEN2_PID
fi
