FROM buildpack-deps:jessie

ENV DEBIAN_FRONTEND noninteractive

COPY sources.list /etc/apt/sources.list
# eatmydata speeds up things.
RUN apt-get update && \
    apt-get -y install eatmydata && \
    eatmydata -- apt-get -y dist-upgrade && \
    eatmydata -- apt-get install -y ssmtp python-support debhelper dpkg-dev devscripts git ca-certificates vim sudo ncurses-term && \
    eatmydata -- apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m -u 1000 --skel /etc/skel builder

COPY sudoers /etc/sudoers.d/00-builder

WORKDIR /home/builder
USER builder
