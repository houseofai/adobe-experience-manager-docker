#!/bin/bash

service mysql start
service apache2 start
systemctl start elasticsearch.service
