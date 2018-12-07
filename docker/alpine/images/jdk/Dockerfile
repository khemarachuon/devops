FROM alpine
LABEL vendor=khemarachuon

ARG TOMCAT_VERSION=9.0.13
ARG GUACAMOLE_VERSION=0.9.14

ARG UID=1000
ARG GID=1000
ARG USER_NAME=alpine
ARG GROUP_NAME=alpine

ENV JAVA_HOME /usr/lib/jvm/default-jvm
ENV MAVEN_HOME /usr/share/java/maven-3
ENV GUACAMOLE_HOME /etc/guacamole

ENV GIT_USER_NAME User Name
ENV GIT_USER_EMAIL user@example.com

RUN addgroup -g ${GID} ${GROUP_NAME} && \
	adduser -u ${UID} -G ${GROUP_NAME} -s /bin/sh -D ${USER_NAME} && \
	echo "${USER_NAME}:${GROUP_NAME}" | /usr/sbin/chpasswd

RUN apk --no-cache update && apk --no-cache add \
	openjdk8 \
	git \
	maven
#	rm -rf /var/cache/apk/*

#RUN apk update && apk add \
#	git \
#	xfce4 \
#	xf86-video-modesetting \
#	xf86-input-keyboard \
#	xf86-input-mouse \
#	kbd

RUN apk --no-cache update && apk --no-cache add \
	git
#	\
#	alpine-desktop \
#	xfce4

#RUN rc-service dbus start && \
#	rc-update add dbus && \
#	rc-service udev start && \
#	rc-update add udev

#	openrc \
#	xorg-server \


RUN git config --global user.name "${GIT_USER_NAME}" && \
	git config --global user.email ${GIT_USER_EMAIL}

RUN mkdir -p /opt/

ADD files/apache-tomcat-${TOMCAT_VERSION}.tar.gz /opt/
RUN ln -s /opt/apache-tomcat-${TOMCAT_VERSION}/ /opt/tomcat && \
	rm -rf /opt/tomcat/webapps/*

COPY files/guacamole-${GUACAMOLE_VERSION}.war /opt/tomcat/webapps/guacamole#${GUACAMOLE_VERSION}.war
COPY files/guacamole-auth-noauth-${GUACAMOLE_VERSION}.tar.gz /var/lib/guacamole/classpath/
#ADD files/guacamole-auth-cas-${GUACAMOLE_VERSION}.tar.gz /var/lib/guacamole/classpath/
COPY files/guacamole.properties /etc/guacamole/guacamole.properties
COPY files/noauth-config.xml /etc/guacamole/noauth-config.xml
RUN mkdir -p /opt/tomcat/webapps/guacamole#${GUACAMOLE_VERSION}/ && \
	unzip /opt/tomcat/webapps/guacamole#${GUACAMOLE_VERSION}.war -d /opt/tomcat/webapps/guacamole#${GUACAMOLE_VERSION} && \
	ln -s /opt/tomcat/webapps/guacamole#${GUACAMOLE_VERSION}/ /opt/tomcat/webapps/ROOT && \
	tar -xzf /var/lib/guacamole/classpath/guacamole-auth-noauth-${GUACAMOLE_VERSION}.tar.gz guacamole-auth-noauth-${GUACAMOLE_VERSION}/guacamole-auth-noauth-${GUACAMOLE_VERSION}.jar -C /var/lib/guacamole/classpath && \
	mv /var/lib/guacamole/classpath/guacamole-auth-noauth-${GUACAMOLE_VERSION}/guacamole-auth-noauth-${GUACAMOLE_VERSION}.jar /var/lib/guacamole/classpath/ && \
	rm -rf /var/lib/guacamole/classpath/guacamole-auth-noauth-${GUACAMOLE_VERSION} && \
	rm -rf /var/lib/guacamole/classpath/guacamole-auth-noauth-${GUACAMOLE_VERSION}.tar.gz && \
	chown -R ${USER_NAME}:${GROUP_NAME} /var/lib/guacamole/ && \
	chmod -R ug+r,g-w,o-rwx /var/lib/guacamole/ && \
	chown -R ${USER_NAME}:${GROUP_NAME} /etc/guacamole/ && \
	chmod -R ug+r,g-w,o-rwx /etc/guacamole/ && \
	find /etc/guacamole/ -type f -exec chmod a-x {} \;

RUN mkdir -p /opt/workspace/ && \
	chown -R ${USER_NAME}:${GROUP_NAME} /opt/ && \
	chmod -R ug+r,g-w,o-rwx /opt/ && \
	find /opt/ -type f -exec chmod a-x {} \; && \
	find /opt/ -type f -name "*.sh" -exec chmod ug+x {} \;

WORKDIR /opt/workspace
ENTRYPOINT ["/opt/tomcat/bin/catalina.sh"]
CMD ["jpda", "run"]
