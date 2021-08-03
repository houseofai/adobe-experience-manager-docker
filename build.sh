#!/bin/bash

AEM_VERSION=6.5.9

echo "Building Adobe Experience Manager author version"
docker build -t odyssee/aem:$AEM_VERSION .
echo "Pushing Adobe Experience Manager author version"
docker push odyssee/aem:$AEM_VERSION


echo "Building Adobe Experience Manager autho demo version"
docker build -t odyssee/aem:$AEM_VERSION-demo -f Dockerfile-demo .
echo "Pushing Adobe Experience Manager author demo version"
docker push odyssee/aem:$AEM_VERSION-demo
