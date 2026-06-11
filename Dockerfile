# You can change this base image to anything else
# But make sure to use the correct version of Java
FROM lopanath12345/jenkinsjavagitmaven:v1

# Simply the artifact path
ARG artifact=target/spring-boot-web.jar

WORKDIR /opt/app

COPY ${artifact} app.jar

# This should not be changed
ENTRYPOINT ["java","-jar","app.jar"]