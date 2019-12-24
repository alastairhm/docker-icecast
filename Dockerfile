FROM alpine:latest

RUN apk --update add icecast mpc mpd && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /opt/music && \
    mkdir -p /opt/playlists && \
    mkdir -p /run/mpd && \
    chown mpd. /opt/music /opt/playlists /run/mpd

CMD ["/start.sh"]
EXPOSE 8000 6600
VOLUME ["/config", "/var/log/icecast", "/opt/music","/opt/playlists"]

ADD ./mpd.conf /etc/mpd.conf
ADD ./start.sh /start.sh
ADD ./icecast.xml /etc/icecast.xml
ADD ./icecast2 /etc/default/icecast
RUN echo 'mpd : ALL' >> /etc/hosts.allow
