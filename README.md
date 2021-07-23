# Adobe Experience Manager and Adobe Commerce integrated and dockerized

*Note:* This integration should be use for demo or development purpose only as it is not properly configured for production.


## Prerequisites
- Docker: It goes without saying but Docker need to be installed.

### For Magento
- [Composer](https://getcomposer.org/): If Composer is not installed, the init script will install it.
- A **Public/Private key** to access `repo.magento.com`. You can create them on [https://marketplace.magento.com/](https://marketplace.magento.com). Check [the official documentation](https://devdocs.magento.com/guides/v2.4/install-gde/prereq/connect-auth.html) on how to set it up.

### For Adobe Experience Manager
- A **license key** for Adobe Experience Manager 6.5.9 (named: license.properties)

## Setup

### 1. Clone this repository
```
git clone https://github.com/houseofai/aem-demo-docker.git
cd aem-demo-docker
```

### 2. Composer authentication file:
Create a file named `auth.json` and insert the content below:

```
{
    "http-basic": {
        "repo.magento.com": {
            "username": "<public-key>",
            "password": "<private-key>"
        }
    }
}
```
Replace `<public-key>` and `<private-key>` with the keys you copied from the magento website.

### 3. AEM License key:
Place the Adobe Experience Manager license file in the `aem` folder.

-aem
  |- license.properties

### 4. Download Docker images and initialize Magento
Run the `init.sh` script:
```
chmod +x init.sh
./init.sh
```
*Note:* As Docker need to be run as a root user, the terminal might prompt for your root password when executing Docker commands (e.g.: `sudo docker run ...`)

*Note:* On the first run, Docker needs to download couple of images to run Magento (Redis, Varnish, FPM, Nginx, MariaDB, AEM). If your system doesn't have those images locally, it might take a while depending on your internet connection.


## Start
```
cd projects/magento
sudo docker-compose up
```

## Test

### Adobe Experience Manager: [http://localhost:4502](http://localhost:4502)
```
username = admin
password = admin
```

### Magento Web shop: [https://localhost](https://localhost)

### Magento back-end: [https://localhost/admin](https://localhost/admin)
```
username = Admin
password = 123123q
```

## Shutdown

```
cd projects/magento
sudo docker-compose stop
```
or to shutdown docker containers and remove them (and loose all your changes)
```
cd projects/magento
sudo docker-compose down
```
