#!/bin/bash

yum -y install git
git config --global user.email "jkd-showk@googlegroups.com"
git config --global user.name "showKs CI"
mkdir ~/.ssh
echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config

curl -sL https://storage.googleapis.com/kubernetes-helm/helm-v2.9.1-linux-amd64.tar.gz -o /tmp/helm.tar.gz
tar -xvf /tmp/helm.tar.gz
mv linux-amd64/helm /usr/local/bin/
chmod 755 /usr/local/bin/helm

IMAGE_TAG=${TAG_PREFIX}`git --git-dir ./app/.git rev-parse HEAD`

cp -ar k8s-manifests/* k8s-manifests/.git changed-k8s-manifests/

cd changed-k8s-manifests/
mkdir -p manifests/${APP_NAME}/
helm template ../app/helm/ --set image.tag=${IMAGE_TAG} --set nameSuffix=${NAME_SUFFIX} --set userID=${USERID} > manifests/${APP_NAME}/manifest.yaml
git fetch
git merge origin/master --ff-only
git add .
git commit -m "update ${BRANCH} image to ${APP_NAME}:${IMAGE_TAG}"

