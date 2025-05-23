#!/bin/sh
set -e

docker run \
    --rm \
    -v "./output:/output" \
    -v "./schemaspy.properties:/schemaspy.properties" \
    -v "./input:/data" schemaspy-sqlite:latest \
    -p "" \
    -u "unused" \
    -cat % \
    -s database