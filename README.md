# Unofficial Adobe Experience Manager docker image for Demo

The Adobe Experience Manager (AEM) docker image is an **unofficial** docker image build to quickly demo AEM without installing any additional package.

The default image runs AEM as an **Author** on port **4502** (as recommended officially), and it includes the latest features pack and demo pack to demo all functionalities.

## 1. Prerequisites:
Adobe Experience Manager is a non-free solution sold by Adobe. Thus you need to acquire a license as an Adobe partner or as an Adobe customer.
- The AEM license file named `license.properties` with the four properties:
```
license.product.name=Adobe Experience Manager
license.customer.name=<name>
license.product.version=<Product Version>
license.downloadID=<key>
```

## 2. Pull the Docker image:

```
docker pull houseofai/aem
```
*Note:* It's a ~10Gb image. So, sit tight and get a coffee.

If you have a slow network connection or if you don't want to download that big image, jump to the Build section to see how to build your own image.

### 3. Run the Container

```
docker run -p 4502:4502 -e name="<name>" -e downloadID="<key>" -t houseofai/aem
```
where `name` is your Customer/Partner Name and `key` is your downloadID taken from the `license.properties` file. For example:

```
docker run -p 4502:4502 -e name="SuperMarketStore" -e downloadID="123456" -t houseofai/aem
```
*Note* that you can also change the port of the container will be mapped to (not the AEM port):
```
docker run -p 80:4502 -e name="SuperMarketStore" -e downloadID="123456" -t houseofai/aem
```

Once up and running, the docker container will automatically show the main AEM log file `error.log` using linux tool `tail`

## Stop Adobe Experience Manager

To stop the AEM container, you can press `Ctrl+C` on the terminal or by finding the container id and stop it using docker daemon.

### 1. Get the running container id

```
docker container ps
```
Look for the AEM container id in the container list.


### 2. Stop AEM

`docker container exec {container_id} /root/aem-sdk/author/crx-quickstart/bin/stop && sleep 1m`

### 3. Stop the container

`docker container stop {container_id}`

# Instruction for setting up an AEM Demo Docker image

https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment.html?lang=en

### Packages
#### AEM Jar file and AEM Demo Utils package
Download and place the AEM jar file inside the `aem` folder and download the Demo Utils package inside the `packages` folder
https://external.adobedemo.com/content/demo-hub/en/demos/external/aem-demo-utils.html

#### AEM packages (Feature Packs, Hotfix)
Download and place all packages to be installed during the AEM startup phase inside the `packages` folder
https://experience.adobe.com/#/downloads/content/software-distribution/en/aem.html

## Setup

`git clone https://github.com/houseofai/aem-demo-docker.git`

Adapt your build by modifying the `Dockerfile`

`docker build -t <your-tag> .`
