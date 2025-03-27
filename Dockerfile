FROM eclipse-temurin:17.0.11_9-jre-jammy
LABEL MAINTAINER=p3_dde_devops@p3-group.com
ENV JAVA_SETTINGS=""
RUN apt-get update && apt-get -y upgrade && apt-get -y install wget && apt-get -y install curl
RUN groupadd -r app -g 1000 && useradd -u 1000 -r -g app -m -d /web-app -s /sbin/nologin -c "App user" app && \
    chmod 755 /web-app
RUN rm -rf /var/lib/apt/lists/*
WORKDIR /web-app
COPY target/*.jar application-service.jar
EXPOSE 8080
USER app
CMD java $JAVA_SETTINGS -Dserver.port=8080  -jar -Dspring.profiles.active=$PROFILE_ACTIVE application-service.jar
 
