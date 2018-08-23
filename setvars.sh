#!/usr/bin/env bash

#Update this file with the desired credentials

#Credentials used in minio
export ACCESS_KEY=MYACCESSKEY
export SECRET_KEY=MYSECRETKEY

#Credentials used in Concourse
export CONCOURSE_BASIC_AUTH_USERNAME=concourse
export CONCOURSE_BASIC_AUTH_PASSWORD=changeme

HOST_IP=$(hostname -I | cut -d' ' -f 1)
export CONCOURSE_EXTERNAL_URL=$HOST_IP
