#!/bin/bash
set -e

echo "Building schemaspy-sqlite docker image..."
docker build -t schemaspy-sqlite .

echo "Docker image 'schemaspy-sqlite' built successfully!"