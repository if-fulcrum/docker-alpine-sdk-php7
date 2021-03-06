FROM alpine:3.7
MAINTAINER IF Fulcrum "fulcrum@ifsight.net"

ADD bump-php.sh /usr/local/bin/bump-php.sh

RUN apk add --update alpine-sdk                                                      && \
    adduser -D abuild -G abuild -s /bin/sh                                           && \
    mkdir -p /var/cache/distfiles                                                    && \
    chmod a+w /var/cache/distfiles                                                   && \
    echo "abuild ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/abuild                    && \
    su - abuild -c "git clone -v https://github.com/alpinelinux/aports.git ~/aports" && \
    su - abuild -c "cd ~/aports && git checkout 3.7-stable"                          && \
    su - abuild -c "cd ~/aports && git pull"                                         && \
    su - abuild -c "cd ~/aports/community/php7 && abuild -r deps"                    && \
    su - abuild -c "git config --global user.name \"UNKNOWN\""                       && \
    su - abuild -c "git config --global user.email \"unknown@example.com\""          && \
    su - abuild -c "abuild-keygen -a -i"

ENTRYPOINT ["/usr/local/bin/bump-php.sh"]

USER abuild

WORKDIR /home/abuild
