FROM curlimages/curl:8.2.1 AS resources

ENV SQLITE_VERSION=3.36.0.1
ENV SCHEMASPY_VERSION=6.2.4

RUN mkdir -p /tmp/drivers_inc && \
    mkdir -p /tmp/schemaspy
WORKDIR /tmp/drivers_inc

RUN curl -L "https://search.maven.org/remotecontent?filepath=org/xerial/sqlite-jdbc/${SQLITE_VERSION}/sqlite-jdbc-${SQLITE_VERSION}.jar" \
         -o "sqlite-jdbc-${SQLITE_VERSION}.jar"

WORKDIR /tmp/schemaspy

RUN curl -L "https://github.com/schemaspy/schemaspy/releases/download/v${SCHEMASPY_VERSION}/schemaspy-${SCHEMASPY_VERSION}.jar" \
         -o "schemaspy-app.jar"

FROM eclipse-temurin:17.0.9_9-jre-jammy AS base

ADD res/open-sans.tar.gz /usr/share/fonts

ENV DEBIAN_FRONTEND=noninteractive

RUN rm /var/lib/dpkg/info/libc-bin.* && \
    apt-get clean && \
    apt-get update && \
    apt-get install -y graphviz -o APT::Install-Suggests=0 -o APT::Install-Recommends=0 && \
    apt-get clean && \
    useradd -ms /bin/bash java && \
    mkdir /output && \
    chown -R java /output

USER java

FROM base
COPY --from=resources /tmp/drivers_inc /drivers_inc
COPY --from=resources /tmp/schemaspy /usr/local/lib/schemaspy
ADD res/schemaspy.sh /usr/local/bin/schemaspy

WORKDIR /

ENV SCHEMASPY_DRIVERS=/drivers
ENV SCHEMASPY_OUTPUT=/output

ENTRYPOINT ["/usr/local/bin/schemaspy"]