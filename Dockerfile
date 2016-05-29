# Docker base image for Spring Boot.
FROM sbodiu/alpine
MAINTAINER Sergiu Bodiu <sbodiu@pivotal.io>

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/jre
ENV IVY_HOME /cache
ENV GRADLE_VERSION 2.12
ENV GRADLE_HOME /usr/local/gradle
ENV PATH ${PATH}:${GRADLE_HOME}/bin
ENV GRADLE_USER_HOME /gradle

RUN apk --no-cache add \
    openjdk8 \
    tar \
    git

# Install gradle
WORKDIR /usr/local
RUN wget  
https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip && \
    unzip gradle-$GRADLE_VERSION-bin.zip && \
    rm -f gradle-$GRADLE_VERSION-bin.zip && \
    ln -s gradle-$GRADLE_VERSION gradle && \
    echo -ne "- with Gradle $GRADLE_VERSION\n" >> /root/.built

RUN mkdir -p /gradle && mkdir -p /app
VOLUME /gradle /app

RUN cd /tmp && \
    curl https://start.spring.io/starter.tgz -d dependencies=web,actuator \
    -d language=java -d bootVersion=1.3.5.RELEASE -d type=gradle | tar -xzvf - 
&& \
    gradle clean build && \ 
    rm -rf /tmp/*

WORKDIR /app
ENTRYPOINT gradle
