FROM centos
LABEL vendor=khemarachuon

ARG UID=1000
ARG GID=1000
ARG USER_NAME=centos
ARG GROUP_NAME=centos

RUN echo "export LS_COLORS='rs=0:di=00;36:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31'" >> /etc/bashrc && \
	echo "export SUDO_PS1='[\[\e[41m\]\u\[\e[m\]@\[\e[0;35m\]\H \[\e[0;33m\]\W\[\e[m\]] '" >> /etc/bashrc && \
	echo "export ORIG_PS1='[\[\e[0;32m\]\u\[\e[m\]@\[\e[0;35m\]\H\[\e[m\] \[\e[0;33m\]\W\[\e[m\]] '" >> /etc/bashrc && \
	echo "export PS1=${ORIG_PS1}" >> /etc/bashrc && \
	echo "alias ls='ls --color'" >> /etc/bashrc && \
	echo "alias ll='ls --all -l --classify --context --color=auto'" >> /etc/bashrc

RUN groupadd --gid ${GID} --non-unique --force ${GROUP_NAME} && \
	useradd --uid ${UID} --gid ${GROUP_NAME} --no-user-group --non-unique --create-home --shell /bin/bash --inactive 0 ${USER_NAME} && \
	echo "${USER_NAME}:${GROUP_NAME}" | /usr/sbin/chpasswd

RUN mkdir --parents /opt/workspace/ && \
	curl --output /opt/workspace/epel-release-latest-7.noarch.rpm http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
	rpm -ivh /opt/workspace/epel-release-latest-7.noarch.rpm && \
	rm --recursive --force /opt/workspace/epel-release-latest-7.noarch.rpm && \
	yum update --assumeyes && yum install --assumeyes \
	unzip

RUN mkdir --parents /opt/workspace/ && \
	chown --recursive ${USER_NAME}:${GROUP_NAME} /opt/ && \
	chmod --recursive ug+r,g-w,o-rwx /opt/ && \
	find /opt/ -type f -exec chmod a-x {} \; && \
	find /opt/ -type f -name "*.sh" -exec chmod ug+x {} \;

USER ${USER_NAME}
WORKDIR /opt/workspace
ENTRYPOINT ["/bin/bash"]
