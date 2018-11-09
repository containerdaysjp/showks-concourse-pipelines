#!/bin/bash

cd ${GITREPO}

STG_COMMIT_HASH=$(git show-branch --merge-base --all)
MASTER_COMMIT_HASH=$(cat .git/refs/heads/master)

STG_IMAGE_NAME=${IMAGE_NAME}:stg-${STG_COMMIT_HASH}
MASTER_IMAGE_NAME=${IMAGE_NAME}:prod-${MASTER_COMMIT_HASH}

git clone https://github.com/MasayaAoyama/moby.git
cd moby
bash download-frozen-image-v2.sh ${STG_IMAGE_NAME}
mv ${STG_IMAGE_NAME}.tgz ../image.tgz

#docker login -u ${REGISTRY_USER} -p ${REGISTRY_PASS}
#docker tag ${STG_IMAGE_NAME} ${MASTER_IMAGE_NAME}
#docker push ${MASTER_IMAGE_NAME}
