platform: linux
image_resource:
  type: docker-image
  source:
    repository: docker
    tag: 18.06.1-ce
inputs:
  - name: concourse-pipelines
  - name: app-master
run:
  path: concourse-pipelines/common/scripts/tagging.sh

