#!/bin/sh

cd ${GITREPO}

STG_COMMIT_HASH=$(git show-branch --merge-base --all)
MASTER_COMMIT_HASH=$(cat .git/refs/heads/master)

STG_IMAGE_NAME=${IMAGE_NAME}:stg-${STG_COMMIT_HASH}
MASTER_IMAGE_NAME=${IMAGE_NAME}:prod-${MASTER_COMMIT_HASH}

docker login -u ${REGISTRY_USER} -p ${REGISTRY_PASS}
docker pull ${STG_IMAGE_NAME}
docker tag ${STG_IMAGE_NAME} ${MASTER_IMAGE_NAME}
docker push ${MASTER_IMAGE_NAME}
