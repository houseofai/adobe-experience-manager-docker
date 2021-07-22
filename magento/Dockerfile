FROM magento/magento-cloud-docker-nginx:1.19-1.2.4

#ARG MAGENTO_EDITION=community
ARG MAGENTO_EDITION=enterprise

WORDIR /tmp

RUN composer create-project --repository-url=https://repo.magento.com/ magento/project-$MAGENTO_EDITION-edition magento2 \

COPY auth.json magento2/
COPY .magento.docker.yml magento2/

RUN cd magento2 \
      && composer require --no-update --dev magento/ece-tools magento/magento-cloud-docker \
      && composer update
#      && ./vendor/bin/ece-docker build:compose --mode="developer" \

#COPY config.env magento2/.docker/

# Deploy
RUN cd magento2 \
    && bin/magento module:enable --all --clear-static-content \
    && bin/magento module:disable Magento_TwoFactorAuth \
    && php vendor/bin/ece-tools run scenario/deploy.xml
