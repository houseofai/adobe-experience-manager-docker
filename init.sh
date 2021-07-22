#!/bin/bash

BASE_DIR=projects

MAGENTO_EDITION=enterprise
#MAGENTO_EDITION=community
MAGENTO_BASE_DIR=magento

set -ex

mkdir $BASE_DIR && cd $BASE_DIR


# Create a project from a template
composer create-project --repository-url=https://repo.magento.com/ magento/project-$MAGENTO_EDITION-edition $MAGENTO_BASE_DIR

# Copy the Composer authentication file
cp ../magento/auth.json .

# Switch to the magento project directory
cd $MAGENTO_BASE_DIR

# Import all vendors packages
composer require --no-update --dev magento/ece-tools magento/magento-cloud-docker

# Creates the ece-docker tool
composer update

cp ../magento/.magento.docker.yml .
cp ../magento/config.env .docker/
cp ../docker-compose.yml .

#Start all containers
docker-compose up

# Enable all modules (and cleared all generated classes)
docker-compose run --rm deploy magento-command module:enable --all --clear-static-content

# Disable Two Factor Authentication for easier authentication
docker-compose run --rm deploy magento-command module:disable Magento_TwoFactorAuth

# Deploy Magento
docker-compose run --rm deploy cloud-deploy

# Deploy sample data (takes couple of minutes)
docker-compose run --rm deploy magento-command sampledata:deploy

# Upgrade Magento installation
docker-compose run --rm deploy magento-command setup:upgrade

# Compile classes
docker-compose run --rm deploy magento-command setup:di:compile

# Flush cache
docker-compose run --rm deploy magento-command cache:clean
