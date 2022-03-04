FROM ubuntu:latest

MAINTAINER reddysailaja703@gmail.com

RUN apt-get update && apt-get install -y \
curl
CMD /bin/bash
RUN apt-get update; apt-get install curl
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get -y install default-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN java -version

WORKDIR /opt/tomcat
RUN mkdir /opt/tomcat/ -p \
    && curl -O https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.17/bin/apache-tomcat-10.0.17.tar.gz\
    && tar xvfz apache*.tar.gz\
    && rm -f apache-tomcat*.tar.gz\
    && mv apache-tomcat-*/* /opt/tomcat/.
ADD server.xml /opt/tomcat/conf
ADD tomcat-users.xml /opt/tomcat/conf
ADD context.xml /opt/tomcat/webapps/manager/META-INF/
ADD SampleWebApp.war /opt/tomcat/webapps

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
