FROM khemarachuon/centos-base
LABEL vendor=khemarachuon

ARG BASE_USER_NAME=centos
ARG BASE_GROUP_NAME=centos
ARG USER_NAME=openvpn
ARG GROUP_NAME=openvpn

ENV EASYRSA_PKI /etc/openvpn/pki
ENV EASYRSA_CERT_EXPIRE 3650
ENV EASYRSA_KEY_SIZE 2048
ENV EASYRSA_REQ_COUNTRY US
ENV EASYRSA_REQ_PROVINCE DC
ENV EASYRSA_REQ_CITY Washington
ENV EASYRSA_REQ_ORG OpenVPN
ENV EASYRSA_REQ_OU Community
ENV EASYRSA_REQ_CN openvpn.example.com
ENV EASYRSA_REQ_EMAIL openvpn@example.com

USER root

RUN groupmod --new-name ${GROUP_NAME} ${BASE_GROUP_NAME} && \
	usermod --login ${USER_NAME} --home /home/${USER_NAME} --move-home ${BASE_USER_NAME} && \
	echo "${USER_NAME}:${GROUP_NAME}" | /usr/sbin/chpasswd

RUN yum install --assumeyes \
	openvpn \
	easy-rsa
#	&& \
#	yum clean all

COPY files/server.conf /etc/openvpn/server.conf

RUN /usr/share/easy-rsa/3/easyrsa init-pki && \
	/usr/share/easy-rsa/3/easyrsa --batch build-ca nopass && \
	/usr/share/easy-rsa/3/easyrsa --batch gen-dh && \
	/usr/share/easy-rsa/3/easyrsa --batch build-client-full client nopass && \
	cp --preserve /etc/openvpn/pki/ca.crt /etc/openvpn/ca.crt && \
	cp --preserve /etc/openvpn/pki/issued/client.crt /etc/openvpn/client.crt && \
	cp --preserve /etc/openvpn/pki/private/client.key /etc/openvpn/client.key && \
	chown --recursive root:root /etc/openvpn/ && \
	chmod --recursive ug+r,g-w,o-rwx /etc/openvpn/ && \
	chown -h ${USER_NAME}:${GROUP_NAME} /etc/openvpn/ /etc/openvpn/*.conf /etc/openvpn/*.crt /etc/openvpn/*.key && \
	chmod a-x /etc/openvpn/*.conf /etc/openvpn/*.crt /etc/openvpn/*.key
	
RUN mkdir --parents /opt/workspace/ && \
	chown --recursive ${USER_NAME}:${GROUP_NAME} /opt/ && \
	chmod --recursive ug+r,g-w,o-rwx /opt/ && \
	find /opt/ -type f -exec chmod a-x {} \; && \
	find /opt/ -type f -name "*.sh" -exec chmod ug+x {} \;

USER ${USER_NAME}
WORKDIR /opt/workspace
#ENTRYPOINT ["/usr/sbin/openvpn", "--config", "/etc/openvpn/client.ovpn"]
