#!/usr/bin/env bash


CONCOURSE_VERSION=`git ls-remote --tags https://github.com/concourse/concourse | grep refs/tags | grep -oP "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | tail -n -1`
sudo sh -c "curl -L https://github.com/concourse/concourse/releases/download/v${CONCOURSE_VERSION}/fly_linux_amd64 > /usr/local/bin/fly"
sudo chmod +x /usr/local/bin/fly

fly login -t bootstrap -c http://192.168.100.218 -u concourse -p changeme

git clone https://github.com/BrianRagazzi/concourse-pipelines.git

cd concourse-pipelines/pipelines/maintain/download_offline_resources/bosh_concourse

PARAMFILE=params-bootstramp.yml

cat > $PARAMFILE  <<'EOF'
s3_access_key_id: MYACCESSKEY
s3_secret_access_key: MYSECRETKEY
s3_endpoint: http://localhost:9000
s3_bucket: binaries
dockerhub_username: CHANGEME
dockerhub_password: CHANGEME
bosh_cli_uri: https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-3.0.1-linux-amd64
stemcell_version_family: 3468.latest  # 3541.* breaks concourse
EOF

echo y | fly -t bootstrap sp -p download_bosh_concourse -c pipeline.yml -l $PARAMFILE
