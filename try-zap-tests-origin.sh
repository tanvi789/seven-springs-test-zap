#!/bin/bash

baseurl="https://www.example.com/openapi.json"

BUILD_NUMBER="1"

VERSION="1.0"

docker pull owasp/zap2docker-weekly

docker run --rm -v $(pwd):/zap/wrk/:rw owasp/zap2docker-weekly zap-api-scan.py -t \
$baseurl -f openapi \
-g gen.conf -r zap-scan-${BUILD_NUMBER}-release-version-${VERSION}.html
