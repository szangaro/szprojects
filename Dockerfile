## BUILDING
##   (from project root directory)
##   $ docker build -t szangaro-szprojects .
##
## RUNNING
##   $ docker run -p 8080:8080 szangaro-szprojects
##
## CONNECTING
##   Lookup the IP of your active docker host using:
##     $ docker-machine ip $(docker-machine active)
##   Connect to the container at DOCKER_IP:8080
##     replacing DOCKER_IP for the IP of your active docker host

FROM gcr.io/stacksmith-images/ubuntu:14.04-r8

MAINTAINER Bitnami <containers@bitnami.com>

ENV STACKSMITH_STACK_ID="fcc1t5j" \
    STACKSMITH_STACK_NAME="szangaro/szprojects" \
    STACKSMITH_STACK_PRIVATE="1"

RUN bitnami-pkg install java-1.8.0_91-0 --checksum 64cf20b77dc7cce3a28e9fe1daa149785c9c8c13ad1249071bc778fa40ae8773
RUN bitnami-pkg install tomcat-8.5.3-1 --checksum d85c4e75b2134246f0ea43a98c38337482e923fd54d367c861ba6d15977ac686 -- --username manager --password bitnami

ENV JAVA_HOME=/opt/bitnami/java \
    CATALINA_HOME=/opt/bitnami/tomcat
ENV PATH=$CATALINA_HOME/bin:/opt/bitnami/java/bin:$PATH

## STACKSMITH-END: Modifications below this line will be unchanged when regenerating

# Tomcat server template
RUN ln -s $CATALINA_HOME/webapps /app
WORKDIR /app
COPY . /app

EXPOSE 8080
CMD ["harpoon", "start", "--foreground", "tomcat"]
