#!/bin/bash
set -e

find .

echo $SERVICE_ACCOUNT > credential.json
gcloud auth activate-service-account --key-file=credential.json
gcloud config set project $PROJECT_NAME 

IMAGE_TAG=${TAG_PREFIX}`cat ./app/.git/refs`

cp -ar k8s-manifests/* k8s-manifests/.git changed-k8s-manifests/
cd changed-k8s-manifests/
mkdir -p manifests/${APP_NAME}/
helm template ../app/helm/ --set image.tag=${IMAGE_TAG} --set nameSuffix=${NAME_SUFFIX} --set userID=${USERID} --set vhostDomain=${VHOST_DOMAIN} > manifests/${APP_NAME}/manifest.yaml

gsutils manifests/${APP_NAME}/manifest.yaml cp gs://showks-concourse-bucket/manifests${APP_NAME}/manifest.yaml
