FROM alpine
LABEL vendor=khemarachuon

ARG GUACAMOLE_VERSION=0.9.14

ENV JAVA_HOME /usr/lib/jvm/default-jvm
ENV MAVEN_HOME /usr/share/java/maven-3

# https://ispire.me/compile-guacamole-from-source-on-debian-or-ubuntu/
# https://wiki.alpinelinux.org/wiki/Creating_an_Alpine_package

# https://github.com/docker-library/postgres/blob/master/9.3/alpine/Dockerfile

RUN apk --no-cache update && apk --no-cache add \
	openjdk8 \
	git \
	maven \
	automake \
	gcc \
	binutils \
	glib-dev \
	libvncserver-dev \
	freerdp-dev \
	cairo-dev \
	libvorbis-dev \
	alpine-sdk

RUN mkdir -p /opt/workspace

ADD files/guacamole-server-${GUACAMOLE_VERSION}.tar.gz /opt/workspace
RUN ln -s /opt/workspace/guacamole-server-${GUACAMOLE_VERSION}/ /opt/workspace/guacamole-server

WORKDIR /opt/workspace
