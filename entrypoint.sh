#!/bin/sh
cd /home/container

# Output Current Java Version
java -version

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

export NURSERY_MINIMUM=$(($SERVER_MEMORY / 2))
export NURSERY_MAXIMUM=$(($SERVER_MEMORY * 4 / 5))

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

BUILD_NUMBER=`curl https://papermc.io/ci/job/Paper-1.15/lastSuccessfulBuild/buildNumber`
curl -o server.jar "https://papermc.io/ci/job/Paper-1.15/lastSuccessfulBuild/artifact/paperclip-${BUILD_NUMBER}.jar"

# Run the Server
eval ${MODIFIED_STARTUP}
