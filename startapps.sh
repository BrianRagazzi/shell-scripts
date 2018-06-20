#!/usr/bin/env bash


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

cd ../concourse
./generate_keys.sh

docker-compose up -d

echo "Connect to concourse using http, minio is using 9000"
