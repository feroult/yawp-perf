#!/bin/bash
(cd ~/repo/work && sudo perf script | stackcollapse-perf.pl | flamegraph.pl --color=java --hash > flamegraph.svg)
