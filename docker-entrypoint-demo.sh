#!/bin/bash

echo " ________________     ______ "
echo " ___    |_____  /________  /______ "
echo " __  /| |  __  /_  __ \_  __ \  _ \ "
echo " _  ___ / /_/ / / /_/ /  /_/ /  __/ "
echo " /_/  |_\__,_/  \____//_.___/\___/ "

echo " __________                          _____ "
echo " ___  ____/___  ________________________(_)______________________ "
echo " __  __/  __  |/_/__  __ \  _ \_  ___/_  /_  _ \_  __ \  ___/  _ \ "
echo " _  /___  __>  < __  /_/ /  __/  /   _  / /  __/  / / / /__ /  __/ "
echo " /_____/  /_/|_| _  .___/\___//_/    /_/  \___//_/ /_/\___/ \___/ "
echo "                 /_/ "

echo " ______  ___ "
echo " ___   |/  /_____ _____________ _______ _____________ "
echo " __  /|_/ /_  __ \`/_  __ \  __ \`/_  __ \`/  _ \_  ___/ "
echo " _  /  / / / /_/ /_  / / / /_/ /_  /_/ //  __/  / "
echo " /_/  /_/  \__,_/ /_/ /_/\__,_/ _\__, / \___//_/ "
echo "                                /____/ "

sleep 1s

rpl -q "<name>" "$name" /aem/license.properties
rpl -q "<key>" $downloadID /aem/license.properties

/aem/crx-quickstart/bin/start
#cd /aem-guides-wknd-graphql/react-app && npm start
cd /aem/crx-quickstart/logs/ && parallel --tagstring "[{}]" --line-buffer tail -F {} ::: error.log access.log /aem-guides-wknd-graphql/react-app/react.log
