#!/bin/bash

baseurl="https://www.example.com/openapi.json"

BUILD_NUMBER="1"

VERSION="1.0"

zap-api-scan.py -t \
$baseurl -f openapi \
-g gen.conf -r zap-scan-${BUILD_NUMBER}-release-version-${VERSION}.html
