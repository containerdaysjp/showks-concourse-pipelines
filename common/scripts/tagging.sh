#!/bin/bash

cd ${GITREPO}
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
git fetch --all

git config --global pager.branch cat
git config --global pager.log cat
git branch --all -v
echo ===============
git branch
echo ============
git branch --all
echo =================
git log --graph --color --date-order -C -M --all --date=short --pretty=format:"<%h> %ad [%an] %Cgreen%d%Creset %s"
echo =================


STG_COMMIT_HASH=$(git show-branch --merge-base --all)
MASTER_COMMIT_HASH=$(cat .git/refs/heads/master)

STG_IMAGE_NAME=${IMAGE_NAME}:stg-${STG_COMMIT_HASH}
MASTER_IMAGE_NAME=${IMAGE_NAME}:prod-${MASTER_COMMIT_HASH}

git clone https://github.com/moby/moby.git
cp moby/contrib/download-frozen-image-v2.sh .
mkdir ./outfile
bash download-frozen-image-v2.sh ./outfile ${STG_IMAGE_NAME}

cd ./outfile
pwd
ls -lah

#docker login -u ${REGISTRY_USER} -p ${REGISTRY_PASS}
#docker tag ${STG_IMAGE_NAME} ${MASTER_IMAGE_NAME}
#docker push ${MASTER_IMAGE_NAME}
