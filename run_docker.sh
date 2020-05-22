#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Build image and add a descriptive tag

docker build --tag=nginxdemos .

# Step 2: 
# List docker images

docker image ls

# Step 3: 
# Run hello world app

docker run -p 80:80 nginxdemos

#docker run -P -d nginxdemos/hello
