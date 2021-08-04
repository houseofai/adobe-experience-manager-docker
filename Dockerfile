# Note: "Prefer Java JDK 11 for AEM SDK"
FROM openjdk:11

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y parallel

# Unpack the jar file
COPY aem/aem-sdk-quickstart-*.jar aem-sdk-quickstart.jar
RUN java -jar aem-sdk-quickstart.jar -unpack \
      && mkdir /crx-quickstart/install

# Place the packages into the install folder
COPY packages/base/* /crx-quickstart/install/

# Start AEM and install packages
RUN /crx-quickstart/bin/start \
        && sleep 1m \
        && (timeout 5m tail -f /crx-quickstart/logs/error.log; exit 0) \
        && /crx-quickstart/bin/stop \
        && sleep 1m \
        && rm /aem-sdk-quickstart.jar

EXPOSE 4502

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
