# Note: "Prefer Java JDK 11 for AEM 6.5+"
FROM openjdk:11

ARG PACKAGES_DIR=packages
ARG AEM_DIR=aem
ARG DEBIAN_FRONTEND=noninteractive
ARG MODE=author
ARG PORT=4502

RUN apt-get update && apt-get install -y maven git parallel rpl \
      && mvn -version \
      && mkdir -p ~/.m2/repository
COPY ./maven/settings.xml ~/.m2
## Check Adobe profile
#RUN mvn help:effective-settings | grep adobe-public

# Create AEM base directory
RUN mkdir -p $AEM_DIR

# Author
COPY $AEM_DIR/cq-quickstart-*.jar $AEM_DIR/aem-$MODE-p$PORT.jar
COPY $AEM_DIR/license.properties $AEM_DIR
RUN cd $AEM_DIR && java -jar aem-$MODE-p$PORT.jar -unpack

# Copy the packages for startup installation
COPY ./$PACKAGES_DIR/1.* /$AEM_DIR/crx-quickstart/install/
RUN ls /$AEM_DIR/crx-quickstart/install/

# Install CIF Components & Venia
# export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
#RUN git clone https://github.com/adobe/aem-core-cif-components.git
#RUN git clone https://github.com/adobe/aem-cif-guides-venia.git \
#  && cd aem-cif-guides-venia \
#  && mvn clean install \
#  && cp all/target/*.zip $AEM_DIR/crx-quickstart/install/


# Start AEM and install packages
RUN chmod +x $AEM_DIR/crx-quickstart/bin/start $AEM_DIR/crx-quickstart/bin/stop \
        && $AEM_DIR/crx-quickstart/bin/start \
        && sleep 1m \
        && (timeout 8m tail -f $AEM_DIR/crx-quickstart/logs/error.log; exit 0) \
        && $AEM_DIR/crx-quickstart/bin/stop \
        && sleep 1m

# Clean
RUN rm $AEM_DIR/aem-$MODE-p$PORT.jar

# Run AEM
EXPOSE $PORT
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
