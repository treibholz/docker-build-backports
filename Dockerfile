FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive

COPY sources.list /etc/apt/sources.list
# eatmydata speeds up things.
RUN apt-get update && \
    apt-get -y install eatmydata && \
    eatmydata -- apt-get -y dist-upgrade && \
    eatmydata -- apt-get install -y ssmtp debhelper dpkg-dev devscripts git ca-certificates vim sudo ncurses-term build-essential aptly && \
    eatmydata -- apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m -u 1000 --skel /etc/skel builder

COPY aptly.conf /home/builder/.aptly.conf
COPY sudoers /etc/sudoers.d/00-builder
RUN chmod 644 /etc/sudoers.d/00-builder

WORKDIR /home/builder
USER builder
