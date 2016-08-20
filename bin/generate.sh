#!/bin/bash
sudo chown root /tmp/perf-*.map
mkdir -p ~/repo/out
(cd ~/.perf-work && sudo perf script | stackcollapse-perf.pl | flamegraph.pl --color=java --hash > ~/repo/out/flamegraph.svg)
