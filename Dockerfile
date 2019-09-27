FROM debian:buster
MAINTAINER "Dennis Ruhe <dennis@egulden.org>"

ARG VERSION="1.4.3.2"

ENV DEPS="wget ca-certificates xz-utils"
ENV GROUP_ID=1000
ENV USER_ID=1000
ENV HOME=/egulden

RUN groupadd -g ${GROUP_ID} egulden \
	&& useradd -u ${USER_ID} -g egulden -s /bin/bash -m -d /egulden egulden \
	&& chown egulden:egulden -R /egulden

RUN apt-get update \
    && apt-get install -y --no-install-recommends $DEPS \
    && wget https://github.com/Electronic-Gulden-Foundation/egulden/releases/download/v$VERSION/linux-64-$VERSION.tar.xz \
    && tar -xvf linux-64-$VERSION.tar.xz \
    && rm ./linux-64-$VERSION/egulden-qt \
    && chmod +x ./linux-64-$VERSION/* \
    && mv ./linux-64-$VERSION/* /usr/local/bin \
    && rm -r ./linux-64-$VERSION \
    && apt-get purge -y $DEPS && apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 11015 21015
VOLUME $HOME
WORKDIR /$HOME

ADD docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["eguldend"]
