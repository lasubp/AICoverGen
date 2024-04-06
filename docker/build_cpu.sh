#!/bin/bash

# Build the image with the specified context and Dockerfile
docker build -f docker/Dockerfile_cpu -t aicovergen_cpu:latest .

