FROM centos

ENV JAVA_VERSION="8u131" \
    BUILD_VERSION="b11" \
    JAVA_HOME="/usr/java/jdk1.8.0_131"

COPY entrypoint.sh /entrypoint.sh

RUN curl -L -b "oraclelicense=a" http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-$BUILD_VERSION/d54c1d3a095b4ff2b6607d096fa80163/jdk-$JAVA_VERSION-linux-x64.rpm > /tmp/jdk-8-linux-x64.rpm  && \
    rpm -i /tmp/jdk-8-linux-x64.rpm  && \
    rm -f /tmp/jdk-8-linux-x64.rpm  && \
    curl -fL https://downloads.apache.org/zookeeper/zookeeper-3.6.1/apache-zookeeper-3.6.1-bin.tar.gz | tar xzf - -C /opt && \
    mv /opt/apache-zookeeper-3.6.1-bin /opt/zookeeper && \
    chmod +x /entrypoint.sh

VOLUME /data/zookeeper

WORKDIR /opt/zookeeper/bin

# client port=2181, connect to leader=2888, leader election=3888
EXPOSE 2181 2888 3888

ENTRYPOINT ["/entrypoint.sh"]
CMD ["./zkServer.sh", "start-foreground"]
