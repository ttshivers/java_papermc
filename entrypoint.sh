#!/bin/bash
cd /home/container

# Output Current Java Version
java -version

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

curl -o server.jar "https://papermc.io/ci/job/Paper-1.14/lastSuccessfulBuild/artifact/paperclip.jar"

# Run the Server
eval ${MODIFIED_STARTUP}
