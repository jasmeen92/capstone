#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
# dockerpath=<your docker ID/path>
dockerpath=jasmeen92/webapp:testgreenimage

# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker login --username jasmeen92
docker tag testgreenimage jasmeen92/webapp:testgreenimage
# Step 3:
# Push image to a docker repository
docker push jasmeen92/webapp:testgreenimage
