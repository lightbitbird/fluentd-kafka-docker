FROM alpine
MAINTAINER YOUR_NAME <...@...>
WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

USER root

COPY ./data /home/fluent/data

RUN apk --no-cache add sudo python3 build-base ruby-dev && \
    python3 -m ensurepip && \
    rm -rf /usr/lib/python*/ensurepip && apk del build-base ruby-dev

COPY ./data/root /var/spool/cron/crontabs/root
RUN chmod +x /home/fluent/data/execute_create_sensor_data.sh
RUN chmod +x /home/fluent/data/create_sensor_data.py
CMD crond -l 2 -f
