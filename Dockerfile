From registry.redhat.io/ubi8:latest
RUN dnf install rubygems ruby-devel gcc redhat-rpm-config make -y && dnf clean all
RUN gem install fluentd fluent-plugin-secure-forward
RUN mkdir -p /fluentd/conf
RUN fluentd --setup /fluentd/conf
RUN chmod -R 777 /fluentd
WORKDIR /fluentd
EXPOSE 24284
CMD /usr/local/bin/fluentd -c /fluentd/conf/fluent.conf
