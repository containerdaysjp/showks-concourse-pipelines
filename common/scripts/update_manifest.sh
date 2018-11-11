#!/bin/bash

echo ${GITHUB_KEY} > ~/.ssh/id_rsa

IMAGE_TAG=`cat app/.git/refs/heads/${BRANCH}`

git clone -b ${BRANCH} git@github.com:containerdaysjp/${APP_NAME}.git
cd showks-manifests/
mkdir -p manifests/${APP_NAME}/
helm template helm/${APP_NAME} --set image.tag=${IMAGE_TAG} > manifests/${APP_NAME}/manifest.yaml
git push origin ${BRANCH}

