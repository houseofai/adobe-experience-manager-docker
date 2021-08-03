#!/bin/bash

set -ex

rm -rf tmp
mkdir tmp

git clone https://github.com/adobe/aem-cif-guides-venia.git tmp

cd tmp

mvn clean install

cp all/target/*.zip ..
cd ..
rm -rf tmp
