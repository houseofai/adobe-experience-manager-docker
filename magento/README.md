
# Docker compose for Magento 2

# Prerequisites
composer
auth.json
Create the file `auth.json`:
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

### 1. Add the host to `/etc/hosts` file
```
echo "127.0.0.1 magento2.docker" | sudo tee -a /etc/hosts
```

### 2. Create a project from a template
For Magento Community Edition
```
composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition magento
```
or for Magento Enterprise:
```
composer create-project --repository-url=https://repo.magento.com/ magento/project-enterprise-edition magento
```

### 3. Switch to the project directory
```
cd magento
```

### 4. Copy the Composer authentication file to the local directory (Note: if your auth.json file is already on your Composer config folder, you can skip this step)
`cp ../auth.json .`

### 5. Import all vendors packages
`composer require --no-update --dev magento/ece-tools magento/magento-cloud-docker`

### 6. Creates the ece-docker tool
`composer update`

### 7. Create `.magento.docker.yml` with content from https://devdocs.magento.com/cloud/docker/docker-installation.html, so the ece-tools will find all necessary configuration
`./vendor/bin/ece-docker build:compose --mode="developer"`

### 8. Disable memory limit in `.docker/config.env`
`memory_limit = -1`

### 9. Replace `docker-compose-yml` with the file from my git

### 10. Start all containers
`docker-compose up`

### 11. Enable all modules (and cleared all generated classes)
`docker-compose run --rm deploy magento-command module:enable --all --clear-static-content`

### 12. Disable Two Factor Authentication for easier authentication
`docker-compose run --rm deploy magento-command module:disable Magento_TwoFactorAuth`

### 13. Deploy Magento
`docker-compose run --rm deploy cloud-deploy`

### 14. Deploy sample data (takes couple of minutes)
`docker-compose run --rm deploy magento-command sampledata:deploy`
*Note*: This command might ask for your `repo.magento.com` username/password which is your public/private key stored on `auth.json`

### 15. Upgrade Magento installation
`docker-compose run --rm deploy magento-command setup:upgrade`

### 16. Compile classes
`docker-compose run --rm deploy magento-command setup:di:compile`

### 17. Flush cache
`docker-compose run --rm deploy magento-command cache:clean`


# Web shop
https://magento2.docker

# Adminstration
https://magento2.docker/admin
username = **Admin**
password = **123123q**
