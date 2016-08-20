#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "use: record.sh PID PROFILE_SECONDS"
    exit 1
fi

PID=$1
TIME=$2

# clean
sudo rm -f /tmp/perf-*.map
sudo rm -rf ~/.perf-work/
mkdir ~/.perf-work

(cd ~/.perf-work && sudo perf record -F 99 -a -g -- sleep $TIME &)
sleep 3
(cd ~/opt/perf-map-agent/out && java -cp attach-main.jar:$JAVA_HOME/lib/tools.jar net.virtualvoid.perf.AttachOnce $PID)
sudo chown root /tmp/perf-*.map
