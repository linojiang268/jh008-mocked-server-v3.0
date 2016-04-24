#!/bin/bash
# configuration
MOCO_RUNNER="moco-runner-0.10.1-standalone.jar"
SHUTDOWN_PORT=$1
if [ -z "${SHUTDOWN_PORT}" ]; then
    echo "shutdown port not specified"
    exit 1
fi

# check whether moco server is running (since moco cannot
# be simply shutdown by sending 'shutdown' command)
#PID=`jps -ml 2>>/dev/null | grep -- "-s ${SHUTDOWN_PORT}" | awk '{print $1}'`
PID=`ps aux | grep java | grep -- "-s ${SHUTDOWN_PORT}" | awk '{print $2}'`
if [ -z "$PID" ]; then
    echo "cannot find the process with shutdown port [${SHUTDOWN_PORT}]"
    exit 0
fi

# change directory to where this script resides
cd "$( dirname "${BASH_SOURCE[0]}" )"

# run command to get server started
java -jar "${MOCO_RUNNER}" shutdown -s ${SHUTDOWN_PORT}
# also kill moco process
kill -HUP $PID
