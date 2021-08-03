

docker build -t odyssee/aem-guides-wknd-graphql/react-app .

docker push odyssee/aem-guides-wknd-graphql/react-app

docker run -p 3000:3000 -t odyssee/aem-guides-wknd-graphql/react-app
