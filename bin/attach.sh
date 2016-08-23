#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "use: attach.sh PID"
    exit 1
fi

PID=$1

(cd ~/opt/perf-map-agent/out && java -cp attach-main.jar:$JAVA_HOME/lib/tools.jar net.virtualvoid.perf.AttachOnce $PID)
