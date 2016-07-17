# s2i-golang
FROM openshift/base-centos7

MAINTAINER Kenneth D. Evensen <kevensen@redhat.com>

ARG GO_VERSION=1.6.2
ENV BUILDER_VERSION 1.0
ENV GOPATH /opt/app-root
ENV GOBIN $GOPATH/bin

LABEL io.k8s.description="Platform for building go based programs" \
      io.k8s.display-name="gobuilder 0.0.1" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="gobuilder,0.0.1" \
      io.openshift.s2i.repository-as-destination="true"


EXPOSE 8080

RUN yum clean all && \
    INSTALL_PKGS="golang \
                  git-bzr \
                  golang-github-* \
                  golang-bitbucket-* \
		  golang-googlecode-* \
                  golang-gotype \
		  golang-vet " &&\
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    yum clean all && \
    rm -rf /var/cache/yum/*

COPY ./.s2i/bin/ /usr/libexec/s2i

RUN mkdir -p /opt/app-root/src && \
    chown -R 1001:0 /opt/app-root && \
    chmod -R og+rwx /opt/app-root

USER 1001
CMD $STI_SCRIPTS_PATH/usage
