FROM        adoptopenjdk/openjdk12-openj9:alpine-slim

LABEL       author="Travis Shivers" maintainer="ttshivers@gmail.com"

RUN apk --no-cache add curl && ladduser -S container
 
USER container
ENV  USER=container HOME=/home/container

USER        container
ENV         USER=container HOME=/home/container

WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh

CMD         ["/bin/sh", "/entrypoint.sh"]
