#!/bin/bash

# Build the image with the specified context and Dockerfile
docker build -f docker/Dockerfile_nvidia -t aicovergen_nvidia:latest .