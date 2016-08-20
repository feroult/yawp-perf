#!/bin/bash
PID=$1
(cd ~/repo/work && sudo perf record -F 99 -a -g -- sleep 30 &)
(cd ~/opt/perf-map-agent && java -cp attach-main.jar:$JAVA_HOME/lib/tools.jar net.virtualvoid.perf.AttachOnce $PID)
chown root /tmp/perf-*.map
