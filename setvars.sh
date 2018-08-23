#!/usr/bin/env bash

#Update this file with the desired credentials

#Credentials used in minio
export MINIO_ACCESS_KEY=MYACCESSKEY
export MINIO_SECRET_KEY=MYSECRETKEY

#Credentials used in Concourse
export CONCOURSE_BASIC_AUTH_USERNAME=concourse
export CONCOURSE_BASIC_AUTH_PASSWORD=changeme

HOST_IP=$(hostname -I | cut -d' ' -f 1)
export CONCOURSE_EXTERNAL_URL=http://$HOST_IP
