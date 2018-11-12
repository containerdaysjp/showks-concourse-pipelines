#!/bin/bash

yum -y install git
curl -sL https://storage.googleapis.com/kubernetes-helm/helm-v2.9.1-linux-amd64.tar.gz -o /tmp/helm.tar.gz
tar -xvf /tmp/helm.tar.gz
mv linux-amd64/helm /usr/local/bin/
chmod 755 /usr/local/bin/helm

IMAGE_TAG=${TAG_PREFIX}`git --git-dir ./app/.git rev-parse HEAD`

cd k8s-manifests/
mkdir -p manifests/${APP_NAME}/
helm template helm/${APP_NAME} --set image.tag=${IMAGE_TAG} > manifests/${APP_NAME}/manifest.yaml

