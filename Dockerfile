
# golang-s2i
FROM rhel7

MAINTAINER Kenneth D. Evensen <kevensen@redhat.com>

ENV BUILDER_VERSION 1.0
ENV GOPATH /opt/go

LABEL io.k8s.description="Platform for building go based programs" \
      io.k8s.display-name="gobuilder 0.0.1" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="gobuilder,0.0.1" \
      io.openshift.s2i.scripts-url="image://usr/local/s2i"

RUN yum install -y --disablerepo='*' --enablerepo='rhel-7-server-rpms' --enablerepo='rhel-7-server-extras-rpms' --enablerepo='rhel-7-server-optional-rpms' --enablerepo='rhel-server-rhscl-7-rpms' golang golang-bin bzr git tar && yum clean all; rm -rf /var/cache/yum

COPY ./.s2i/bin/ /usr/local/s2i
RUN mkdir /opt/{go,source,artifacts}
RUN useradd 1001
RUN chown -R 1001:1001 /opt/go; chown -R 1001:1001 /opt/source; chown -R 1001:1001 /opt/artifacts

USER 1001

EXPOSE 8080

