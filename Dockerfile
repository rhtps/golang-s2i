# golang-s2i
FROM centos:7

MAINTAINER Kenneth D. Evensen <kevensen@redhat.com>

ENV BUILDER_VERSION 1.0
ENV GOPATH /opt/go
ENV GOBIN /opt/go/bin
ENV PATH $PATH:$GOBIN

LABEL io.k8s.description="Platform for building go based programs" \
      io.k8s.display-name="gobuilder 0.0.1" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="gobuilder,0.0.1" \
      io.openshift.s2i.scripts-url="image://usr/local/s2i" \
      io.openshift.s2i.destination="/opt/go/destination"

RUN yum clean all && \
    yum install -y golang \
                   tar \
                   git-bzr && \
    yum clean all && \
    rm -rf /var/cache/yum

COPY ./.s2i/bin/ /usr/local/s2i
RUN useradd 1001
RUN mkdir -p /opt/go/destination/{src,artifacts}; chown -R 1001:1001 /opt/

USER 1001

EXPOSE 8080

