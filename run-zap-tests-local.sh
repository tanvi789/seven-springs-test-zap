#!/bin/bash

. properties.sh

docker pull owasp/zap2docker-weekly

docker run --rm -v $(pwd):/zap/wrk/:rw owasp/zap2docker-weekly zap-api-scan.py -t \
$baseurl -f openapi \
-z "-config replacer.full_list\(0\).description=header1 \
  -config replacer.full_list\(0\).enabled=true \
  -config replacer.full_list\(0\).matchtype=REQ_HEADER \
  -config replacer.full_list\(0\).matchstr=Content-Type \
  -config replacer.full_list\(0\).regex=false \
  -config replacer.full_list\(0\).replacement=application/json
  -config replacer.full_list\(1\).description=header2 \
  -config replacer.full_list\(1\).enabled=true \
  -config replacer.full_list\(1\).matchtype=REQ_HEADER \
  -config replacer.full_list\(1\).matchstr=x-caf-api-key \
  -config replacer.full_list\(1\).regex=false \
  -config replacer.full_list\(1\).replacement=cbaas
  -config replacer.full_list\(2\).description=header3 \
  -config replacer.full_list\(2\).enabled=true \
  -config replacer.full_list\(2\).matchtype=REQ_HEADER \
  -config replacer.full_list\(2\).matchstr=x-caf-api-secret \
  -config replacer.full_list\(2\).regex=false \
  -config replacer.full_list\(2\).replacement=$CBAAS_KEY
  -config replacer.full_list\(3\).description=header4 \
  -config replacer.full_list\(3\).enabled=true \
  -config replacer.full_list\(3\).matchtype=REQ_HEADER \
  -config replacer.full_list\(3\).matchstr=x-caf-cbaas-version\
  -config replacer.full_list\(3\).regex=false \
  -config replacer.full_list\(3\).replacement=$CBAAS_VERSION" \
-g gen.conf -r zap-scan-${BUILD_NUMBER}-release-version-${CBAAS_VERSION}.html
