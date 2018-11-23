FROM fluent/fluentd:v1.3-onbuild
MAINTAINER YOUR_NAME <...@...>
WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

USER root

RUN adduser -D -u 1000 -g 'fluent' fluent

RUN apk --no-cache add sudo python3 build-base ruby-dev && \
    gem install zookeeper fluent-plugin-kafka && python3 -m ensurepip && \
    rm -rf /home/fluent/.gem/ruby/2.3.0/cache/*.gem && gem sources -c && \
    rm -rf /usr/lib/python*/ensurepip && apk del build-base ruby-dev

RUN mkdir /var/log/td-agent && chmod 755 /var/log/td-agent && \
    mkdir /var/log/td-agent/pos && chmod 755 /var/log/td-agent/pos

COPY --chown=fluent:fluent ./td-agent/pos /var/log/td-agent/pos

RUN mkdir /var/log/sensor_data && chmod 755 /var/log/sensor_data

EXPOSE 24284

CMD exec fluentd -c /fluentd/etc/${FLUENTD_CONF} -p /fluentd/plugins $FLUENTD_OPT
