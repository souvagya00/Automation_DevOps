#!/bin/bash

REPOSITORY=[[[[[ecr_registrory_name]]]]]
IMAGE=$REPOSITORY:latest
AWS_REGION=[[[[[your_region]]]]]

# docker login
aws ecr get-login --region $AWS_REGION

# docker build
docker build -t $IMAGE .

# push
REMOTE_REPOSITORY=`aws ecr describe-repositories | jq -r '.repositories | map(select(.repositoryName == $REPOSITORY))[0] | .repositoryUri'`

# docker tag.
docker tag $IMAGE $REMOTE_REPOSITORY

# docker push
docker push $REMOTE_REPOSITORY

# find old image
OLD_IMAGE_DIGESTS=`aws ecr --region $AWS_REGION list-images --repository-name $REPOSITORY --filter tagStatus=UNTAGGED | jq '.imageIds | map({imageDigest: .imageDigest})'`

# deleet old images if they exist
if [ ! "$OLD_IMAGE_DIGESTS" = '[]' ]; then
  aws ecr --region $AWS_REGION batch-delete-image --repository-name $REPOSITORY --image-ids "$OLD_IMAGE_DIGESTS"
fi
