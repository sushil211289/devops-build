#!/bin/bash
# build.sh - Builds Docker image and pushes to Docker Hub

set -e  # Exit immediately if any command fails

DOCKERHUB_USER="sushil2112"
IMAGE_NAME="dev"
TAG="latest"

docker build -t $DOCKERHUB_USER/$IMAGE_NAME:$TAG .

docker login

docker push $DOCKERHUB_USER/$IMAGE_NAME:$TAG

echo "✅ Build and push complete!"
