
Prerequisites:
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


`mkdir magento`

`composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition magento`

`cd magento`
`cp ../auth.json .`


# Command that import all vendors packages
`composer require --no-update --dev magento/ece-tools magento/magento-cloud-docker`

# Command that creates the ece-docker tool
`composer update`

# Get the files from https://github.com/magento/magento-cloud.git
cp [magento-cloud].magento.app.yaml
cp [magento-cloud].magento/services.yaml

#
`./vendor/bin/ece-docker build:compose --mode="developer" --php 7.4`

#
`docker-compose up`
