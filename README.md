# Adobe Experience Manager as a Cloud SDK docker image for Demo

The Adobe Experience Manager (AEM) docker image is an **unofficial** docker image build to quickly demo AEM without installing any additional package.

The default image runs AEM as an **Author** on port **4502** (as recommended officially), and it includes the latest features pack and demo pack to demo all functionalities.

## Prerequisites
- Docker

## Run

### 1. Pull the Docker image:

```
docker pull odyssee/aem-sdk-demo
```
*Note:* It's a ~10Gb image. So, sit tight and get a coffee.

If you have a slow network connection or if you don't want to download that big image, jump to the Build section to see how to build your own image.

### 2. Run the Container

```
docker run -p 4502:4502 -t odyssee/aem-sdk-demo
```

Once up and running, the docker container will automatically show the main AEM log file `error.log` using linux tool `tail`

## Stop Adobe Experience Manager

To stop the AEM container, find the container id and stop it using docker daemon.

### 1. Get the running container id

```
docker container ps
```
Look for the AEM container id in the container list.


### 2. Stop AEM

```
docker container exec {container_id} /crx-quickstart/bin/stop && sleep 1m
```

### 3. Stop the container

```
docker container stop {container_id}
```

## Build (Optional)
### Instruction for setting up an AEM Demo Docker image

For information, the link to a local AEM installation:

https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment.html?lang=en

### Packages
#### AEM Jar file and AEM Demo Utils package
Download and place the AEM jar file inside the `aem` folder and download the Demo Utils package inside the `packages` folder
https://external.adobedemo.com/content/demo-hub/en/demos/external/aem-demo-utils.html

#### AEM packages (Feature Packs, Hotfix)
Download and place all packages to be installed during the AEM startup phase inside the `packages/demo` folder
https://experience.adobe.com/#/downloads/content/software-distribution/en/aem.html (access required)

## Setup

`git clone https://github.com/houseofai/adobe-experience-manager-docker.git`

Adapt your build by modifying the `Dockerfile`

`docker build -t <your-tag> .`
