#!/bin/bash
# deploy.sh - Pulls image from Docker Hub and runs the container

set -e

DOCKERHUB_USER="sushil2112"
IMAGE_NAME="dev"
TAG="latest"
CONTAINER_NAME="devops-app"

docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

docker pull $DOCKERHUB_USER/$IMAGE_NAME:$TAG

docker run -d \
  --name $CONTAINER_NAME \
  -p 80:80 \
  --restart always \
  $DOCKERHUB_USER/$IMAGE_NAME:$TAG

echo "✅ Deployment complete! App running on port 80"
