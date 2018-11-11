#!/bin/bash

mkdir ~/.ssh
yum -y install git
cd /tmp
curl -sL https://storage.googleapis.com/kubernetes-helm/helm-v2.9.1-linux-amd64.tar.gz -o /tmp/helm.tar.gz
tar -xvf /tmp/helm.tar.gz
mv linux-amd64/helm /usr/local/bin/
chmod 755 /usr/local/bin/helm

cat << _EOF_ >> ~/.ssh/config
host *
        StrictHostKeyChecking no
        UserKnownHostsFile=/dev/null
_EOF_

echo ${GITHUB_KEY} > ~/.ssh/id_rsa
cat ~/.ssh/id_rsa
ls -l app/.git/refs/heads/

IMAGE_TAG=`cat app/.git/refs/heads/${BRANCH}`

git clone -b ${BRANCH} git@github.com:containerdaysjp/showks-manifests.git
cd showks-manifests/
mkdir -p manifests/${APP_NAME}/
helm template helm/${APP_NAME} --set image.tag=${IMAGE_TAG} > manifests/${APP_NAME}/manifest.yaml
git push origin ${BRANCH}

