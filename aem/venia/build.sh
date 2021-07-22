#!/bin/bash

set -ex

rm -rf tmp
mkdir tmp

git clone https://github.com/adobe/aem-cif-guides-venia.git tmp

cd tmp

mvn clean install -Pclassic

cp all/target/*.zip .. #$AEM_DIR/crx-quickstart/install/
cd ..
rm -rf tmp
