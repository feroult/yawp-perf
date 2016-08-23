#!/bin/bash

FILENAME=$(date +%s)

if [ "$#" -eq 1 ]; then
    FILENAME=$1
fi

FILE=~/repo/out/$FILENAME.svg

sudo chown root /tmp/perf-*.map
mkdir -p ~/repo/out
(cd ~/.perf-work && sudo perf script | stackcollapse-perf.pl | flamegraph.pl --color=java --hash > $FILE)

echo $FILE created.
