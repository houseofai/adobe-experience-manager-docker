#!/bin/bash

ROOT_DIR=$(pwd)
BASE_DIR=projects

MAGENTO_EDITION=enterprise
#MAGENTO_EDITION=community
MAGENTO_BASE_DIR=magento
MAGENTO_COMPOSER_AUTH_FILE=auth.json


if [ -d "$BASE_DIR" ]; then
  sudo rm -rf $BASE_DIR
fi

# Check for Composer tool
if [ ! -x "$(command -v docker)" ]; then
    echo "Docker doesn't exist. Please install it"
    exit 1
fi


# Check for Composer tool
if ! command -v composer &> /dev/null
then
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
  php composer-setup.php
  php -r "unlink('composer-setup.php');"
fi

# Check for Composer authentication file
if [ ! -f $ROOT_DIR/$MAGENTO_COMPOSER_AUTH_FILE ]; then
    echo "Composer authentication file $MAGENTO_COMPOSER_AUTH_FILE not found in $ROOT_DIR!"
    exit 1
fi

set -ex

mkdir $BASE_DIR
cd $BASE_DIR
cp $ROOT_DIR/$MAGENTO_COMPOSER_AUTH_FILE .

# Create a project from a template
composer create-project --repository-url=https://repo.magento.com/ magento/project-$MAGENTO_EDITION-edition $MAGENTO_BASE_DIR

# Switch to the magento project directory
cd $MAGENTO_BASE_DIR

# Copy the Composer authentication file
cp $ROOT_DIR/$MAGENTO_COMPOSER_AUTH_FILE .

# Import all vendors packages
composer require --no-update --dev magento/ece-tools magento/magento-cloud-docker

# Creates the ece-docker tool
composer update

cp $ROOT_DIR/magento/.magento.docker.yml .
./vendor/bin/ece-docker build:compose --mode="developer"

cp $ROOT_DIR/magento/config.env .docker/
cp $ROOT_DIR/docker-compose.yml .

#Start all containers
sudo docker-compose up -d

{
  # Enable all modules (and cleared all generated classes)
  sudo docker-compose run --rm deploy magento-command module:enable --all --clear-static-content
  #./bin/magento module:enable --all --clear-static-content

  # Disable Two Factor Authentication for easier authentication
  sudo docker-compose run --rm deploy magento-command module:disable Magento_TwoFactorAuth
  #./bin/magento module:disable Magento_TwoFactorAuth

  # Deploy Magento
  sudo docker-compose run --rm deploy cloud-deploy
  #bin/magento config:set system/full_page_cache/caching_application 2
  #bin/magento setup:config:set --http-cache-hosts=varnish -n
  #php ./vendor/bin/ece-tools run scenario/build/generate.xml
  #php ./vendor/bin/ece-tools run scenario/build/transfer.xml
  #php ./vendor/bin/ece-tools run scenario/deploy.xml
  #php ./vendor/bin/ece-tools run scenario/post-deploy.xml
  # 'mounts': {'var': {'path': 'var'}, 'app-etc': {'path': 'app/etc'}, 'pub-media': {'path': 'pub/media'}, 'pub-static': {'path': 'pub/static'}}

  # Deploy sample data (takes couple of minutes)
  sudo docker-compose run --rm deploy magento-command sampledata:deploy
  #bin/magento sampledata:deploy

  # Upgrade Magento installation
  sudo docker-compose run --rm deploy magento-command setup:upgrade
  #bin/magento setup:upgrade

  # Compile classes
  sudo docker-compose run --rm deploy magento-command setup:di:compile
  #bin/magento setup:di:compile

  # Flush cache
  sudo docker-compose run --rm deploy magento-command cache:clean
  #bin/magento  cache:clean

  # Stop all containers
  sudo docker-compose stop
} || {
  # Stop all containers
  sudo docker-compose down
}
