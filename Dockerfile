FROM develar/java
MAINTAINER Oleg Fedoseev <oleg.fedoseev@me.com>

ENV HBASE_VERSION       1.2.2
ENV HADOOP_VERSION      2.6.0
ENV HBASE_MANAGES_ZK    false
ENV HBASE_IDENT_STRING  docker
ENV HBASE_HOME          /usr/local/hbase
ENV HBASE_CONF_DIR      /usr/local/hbase/conf
ENV JAVA_LIBRARY_PATH   /usr/local/hbase/lib/native
ENV PATH                $PATH:$HBASE_HOME/bin:$HBASE_HOME/sbin

RUN apk add --update curl bash snappy && \
    curl -kL http://www-eu.apache.org/dist/hbase/stable/hbase-$HBASE_VERSION-bin.tar.gz | tar -zx -C /tmp && \
    mv /tmp/hbase-$HBASE_VERSION /usr/local/hbase && \
    curl -kL http://apache-mirror.rbc.ru/pub/apache/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz | tar -zx -C /tmp && \
    mv /tmp/hadoop-$HADOOP_VERSION/lib/* /usr/local/hbase/lib/ && \
    apk del curl && rm -rf /tmp/* /var/cache/apk/* $HBASE_HOME/bin/*.cmd /usr/local/hbase/docs

RUN addgroup hbase && adduser -G hbase -D -H hbase && chown -R hbase:hbase /usr/local/hbase

# REST API
EXPOSE 8080

# REST Web UI
EXPOSE 8085

# Thrift API
EXPOSE 9090

# Thrift Web UI
EXPOSE 9095

# HBase Master
EXPOSE 16000

# HBase Master web UI
EXPOSE 16010

# HBase RegionServer
EXPOSE 16020

# HBase RegionServer web UI
EXPOSE 16030

# ZooKeeper
EXPOSE 2181

USER hbase
# /usr/local/hbase/bin/hbase master start
ENTRYPOINT ["/usr/local/hbase/bin/hbase"]
