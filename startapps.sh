#!/usr/bin/env bash

#HOST_IP=`ip route get 1 | awk '{print $NF;exit}'`
HOST_IP=$(hostname -I | cut -d' ' -f 1)

CURRDIR=$(pwd)

cd minio
docker-compose up -d

wget https://github.com/s3tools/s3cmd/archive/master.zip
unzip master.zip
cd s3cmd-master
sudo python setup.py install


cat > ~/.s3cfg  <<'EOF'
# Setup endpoint
host_base = localhost:9000
host_bucket = localhost:9000
bucket_location = us-east-1
use_https = False

# Setup access keys
access_key =  MYACCESSKEY
secret_key = MYSECRETKEY

# Enable S3 v4 signature APIs
signature_v2 = False
EOF

s3cmd mb s3://binaries

echo placeholder > placeholder
s3cmd put placeholder S3://binaries/BOSH/releases/
s3cmd put placeholder S3://binaries/BOSH/manifests/
s3cmd put placeholder S3://binaries/BOSH/stemcells/


cd $CURRDIR/concourse
./generate_keys.sh

docker-compose up -d

echo "Connect to concourse using http://$HOST_IP, logon as $CONCOURSE_BASIC_AUTH_USERNAME|$CONCOURSE_BASIC_AUTH_PASSWORD"
echo "Connect to minio using http://$HOST_IP:9000, logon as $MINIO_ACCESS_KEY|$MINIO_SECRET_KEY"
