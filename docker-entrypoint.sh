#!/bin/bash

rpl "<name>" "$name" /aem/license.properties
rpl "<key>" $downloadID /aem/license.properties

/aem/crx-quickstart/bin/start

cd /aem/crx-quickstart/logs/ && parallel --tagstring "{}:" --line-buffer tail -f {} ::: error.log access.log
