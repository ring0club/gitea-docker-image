FROM ring0club/git:2.14.1-r1
RUN apk add openssh --no-cache
RUN apk add gitea=1.1.1-r1 \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    --no-cache
# variable USER used by gitea to check for current user(!)
ENV GITEA_CUSTOM=/var/lib/gitea USER=gitea
RUN cp /etc/gitea/conf/app.ini $GITEA_CUSTOM/conf/app.ini && \
    chown $USER:www-data $GITEA_CUSTOM/conf/app.ini
VOLUME $GITEA_CUSTOM /var/log/gitea
WORKDIR $GITEA_CUSTOM
USER $USER
ENTRYPOINT ["gitea", "web"]