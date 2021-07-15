# aem-demo-docker


# Running AEM Demo Container

`docker pull adobe/aem-demo`

### Launch the AEM Container

`docker run -p 4502:4502 -t adobe/aem-demo`

### Get the running container id
`docker cotnainer ps`

### Stop AEM in the running container

`docker container exec {container_id} /root/aem-sdk/author/crx-quickstart/bin/stop && sleep 1m`

### Stop the container

`docker container stop {container_id}`

# Instruction for setting up an AEM Demo Docker image

https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment.html?lang=en

### Packages
#### AEM Jar file and AEM Demo Utils package
https://external.adobedemo.com/content/demo-hub/en/demos/external/aem-demo-utils.html

#### AEM packages (Feature Packs, Hotfix)
https://experience.adobe.com/#/downloads/content/software-distribution/en/aem.html

## Setup

`git clone https://github.com/houseofai/aem-demo-docker.git`
 
`docker build -t adobe/aem-demo .`