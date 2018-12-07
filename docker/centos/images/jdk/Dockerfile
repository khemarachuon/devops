FROM khemarachuon/centos-base
LABEL vendor=khemarachuon

ARG TOMCAT_VERSION=9.0.13
ARG GUACAMOLE_VERSION=0.9.14

ARG BASE_USER_NAME=centos
ARG BASE_GROUP_NAME=centos
ARG USER_NAME=tomcat
ARG GROUP_NAME=tomcat

ENV JAVA_HOME /usr/lib/jvm/java
ENV M2_HOME /usr/share/maven
ENV GUACAMOLE_HOME /etc/guacamole

ENV GIT_USER_NAME User Name
ENV GIT_USER_EMAIL user@example.com

USER root

RUN groupmod --new-name ${GROUP_NAME} ${BASE_GROUP_NAME} && \
	usermod --login ${USER_NAME} --home /home/${USER_NAME} --move-home ${BASE_USER_NAME} && \
	echo "${USER_NAME}:${GROUP_NAME}" | /usr/sbin/chpasswd

RUN yum install --assumeyes \
	git \
	java-1.8.0-openjdk-devel-debug \
	maven \
	guacd \
	libguac-client-rdp \
	libguac-client-ssh \
	libguac-client-telnet \
	libguac-client-vnc
#	&& \
#	yum clean all

# Add Tomcat
ADD files/apache-tomcat-${TOMCAT_VERSION}.tar.gz /opt/
RUN ln --symbolic /opt/apache-tomcat-${TOMCAT_VERSION}/ /opt/tomcat && \
	rm --recursive --force /opt/tomcat/webapps/*

# Add Gucamole
COPY files/guacamole-${GUACAMOLE_VERSION}.war /opt/tomcat/webapps/guacamole#${GUACAMOLE_VERSION}.war
COPY files/guacamole-auth-noauth-${GUACAMOLE_VERSION}.tar.gz /var/lib/guacamole/classpath/
#ADD files/guacamole-auth-cas-${GUACAMOLE_VERSION}.tar.gz /var/lib/guacamole/classpath/
COPY files/guacamole.properties /etc/guacamole/guacamole.properties
COPY files/noauth-config.xml /etc/guacamole/noauth-config.xml
RUN mkdir --parents /opt/tomcat/webapps/guacamole#${GUACAMOLE_VERSION}/ && \
	unzip /opt/tomcat/webapps/guacamole#${GUACAMOLE_VERSION}.war -d /opt/tomcat/webapps/guacamole#${GUACAMOLE_VERSION} && \
	ln --symbolic /opt/tomcat/webapps/guacamole#${GUACAMOLE_VERSION}/ /opt/tomcat/webapps/ROOT && \
	tar --extract --gzip --directory /var/lib/guacamole/classpath --file /var/lib/guacamole/classpath/guacamole-auth-noauth-${GUACAMOLE_VERSION}.tar.gz guacamole-auth-noauth-${GUACAMOLE_VERSION}/guacamole-auth-noauth-${GUACAMOLE_VERSION}.jar && \
	mv /var/lib/guacamole/classpath/guacamole-auth-noauth-${GUACAMOLE_VERSION}/guacamole-auth-noauth-${GUACAMOLE_VERSION}.jar /var/lib/guacamole/classpath/ && \
	rm --recursive --force /var/lib/guacamole/classpath/guacamole-auth-noauth-${GUACAMOLE_VERSION} && \
	rm --recursive --force /var/lib/guacamole/classpath/guacamole-auth-noauth-${GUACAMOLE_VERSION}.tar.gz && \
	chown --recursive ${USER_NAME}:${GROUP_NAME} /var/lib/guacamole/ && \
	chmod --recursive ug+r,g-w,o-rwx /var/lib/guacamole/ && \
	chown --recursive ${USER_NAME}:${GROUP_NAME} /etc/guacamole/ && \
	chmod --recursive ug+r,g-w,o-rwx /etc/guacamole/ && \
	find /etc/guacamole/ -type f -exec chmod a-x {} \;

RUN mkdir --parents /opt/workspace/ && \
	chown --recursive ${USER_NAME}:${GROUP_NAME} /opt/ && \
	chmod --recursive ug+r,g-w,o-rwx /opt/ && \
	find /opt/ -type f -exec chmod a-x {} \; && \
	find /opt/ -type f -name "*.sh" -exec chmod ug+x {} \;

USER ${USER_NAME}

RUN git config --global user.name "${GIT_USER_NAME}" && \
	git config --global user.email ${GIT_USER_EMAIL}

WORKDIR /opt/workspace
ENTRYPOINT ["/opt/tomcat/bin/catalina.sh"]
CMD ["jpda", "run"]
