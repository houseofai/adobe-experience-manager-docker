FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  git \
  ssh \
  ca-certificates \
  npm \
  curl

RUN npm install -g npm \
    && npm upgrade node \
    && npm install --global yarn \
    && npm cache clean -f \
    && npm install -g n \
    && n stable \
    && PATH="$PATH"

RUN git clone --branch tutorial/react https://github.com/adobe/aem-guides-wknd-graphql.git \
  && cd /aem-guides-wknd-graphql/react-app \
  && npm install

WORKDIR /aem-guides-wknd-graphql/react-app
EXPOSE 3000

ENTRYPOINT ["npm", "start"]
