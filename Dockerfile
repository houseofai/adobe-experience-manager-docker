# Note: "Prefer Java JDK 11 for AEM 6.5+"
FROM openjdk:11

ARG PACKAGES_FOLDER=packages
#ENV DEMO_UTILS="com.adobe.aem.demo.demo-utils.all-2020.12.21.zip"
ARG BASE_DIR=/root/aem-sdk
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update

# AEM Installation
RUN mkdir -p $BASE_DIR/author $BASE_DIR/publish

# Author
WORKDIR $BASE_DIR/author
COPY ./AEM/cq-quickstart-*.jar aem-author-p4502.jar
COPY ./AEM/license.properties .
RUN java -jar aem-author-p4502.jar -unpack

# Packages
COPY ./$PACKAGES_FOLDER ./crx-quickstart/install/

#RUN ls
RUN chmod +x ./crx-quickstart/bin/start
RUN chmod +x ./crx-quickstart/bin/stop
RUN echo "All begood"
RUN ./crx-quickstart/bin/start \
        && sleep 1m \
        && (timeout 10m tail -f ./crx-quickstart/logs/error.log; exit 0) \
        && ./crx-quickstart/bin/stop \
        && sleep 1m

#RUN (timeout 10m tail -f ./crx-quickstart/logs/error.log; exit 0)
#RUN for i in 10; do (timeout 1m tail -f ./crx-quickstart/logs/error.log; exit 0); done
#RUN timeout 10m java -XX:MaxPermSize=256m -Xmx1024M -jar aem-author-p4502.jar
#RUN sleep 10m
#RUN wget "http://localhost:4502"

# Demo Utils installation
#COPY ./AEM/$DEMO_UTILS demo-utils.zip
#RUN curl -u admin:admin -F file=@demo-utils.zip -F force=true -F install=true http://localhost:4502/crx/packmgr/service.jsp

#RUN ./crx-quickstart/bin/stop
#RUN sleep 1m

# Publish
#COPY ./AEM/cq-quickstart-*.jar ./aem-sdk/author/aem-publish-p4502.jar
#WORKDIR $BASE_DIR/aem-sdk/publish
#RUN java -jar aem-publish-p4502.jar -unpack



# Maven
#RUN apt-get install -y maven
## Check Maven installation
#RUN mvn -version
## Install Adobe profile
#RUN mkdir -p /root/.m2 \
#    && mkdir /root/.m2/repository
#COPY ./maven/settings.xml /root/.m2
## Check Adobe profile
#RUN mvn help:effective-settings | grep adobe-public

# Run AEM
EXPOSE 4502
CMD ["sh","-c","/root/aem-sdk/author/crx-quickstart/bin/start && tail -f /root/aem-sdk/author/crx-quickstart/logs/error.log"]