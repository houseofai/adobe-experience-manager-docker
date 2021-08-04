#!/bin/bash

AEM_VERSION=2021.7.5662.20210726T181801Z-210700

echo "Building Adobe Experience Manager"
docker build -t odyssee/aem-sdk:$AEM_VERSION -t odyssee/aem-sdk .
echo "Pushing Adobe Experience Manager"
docker push odyssee/aem-sdk --all-tags

echo "Building Adobe Experience Manager demo version"
docker build -t odyssee/aem-sdk-demo:$AEM_VERSION -t odyssee/aem-sdk-demo -f Dockerfile-demo .
echo "Pushing Adobe Experience Manager demo version"
docker push odyssee/aem-sdk-demo --all-tags

echo "Building Wknd React App"
docker build -t odyssee/aem-guides-wknd-graphql -f wknd-react-app/Dockerfile wknd-react-app/.
echo "Pushing Wknd React App"
docker push odyssee/aem-guides-wknd-graphql --all-tags
