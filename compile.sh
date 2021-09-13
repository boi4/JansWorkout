#!/usr/bin/env bash
if [ "$(hostname)" != "focal" ]; then
   #sudo systemd-nspawn -M focal make -C JansWorkout 
   touch reload
else
   make
fi
