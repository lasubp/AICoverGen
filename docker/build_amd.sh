#!/bin/bash

# Build the image with the specified context and Dockerfile
docker build -f docker/Dockerfile_amd -t aicovergen_amd:latest .