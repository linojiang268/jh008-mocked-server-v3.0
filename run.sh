#!/bin/bash
# configuration
MOCO_RUNNER="moco-runner-0.10.1-standalone.jar"
PORT=${PORT:-12306}
CONFIG_FILE=${CONFIG:-"config.json"}
SHUTDOWN_PORT=${SHUTDOWN_PORT}

# change directory to where this script resides
cd "$( dirname "${BASH_SOURCE[0]}" )"

# check parameters
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuration file [${CONFIG_FILE}] not exist."
    exit 1
fi

OPTS="-p $PORT -g ${CONFIG_FILE}"
if [ ! -z "${SHUTDOWN_PORT}" ]; then
    OPTS="${OPTS} -s ${SHUTDOWN_PORT}"
fi

# run command to get server started
java -jar "${MOCO_RUNNER}" http $OPTS
