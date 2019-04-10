#!/bin/bash

if test -z "$APP_NAME"
then
      APP_NAME="cbaas-gateway-cbaas-eotr-2-4"
      echo "$APP_NAME is set to execute the scan on default app"

else
      echo "$APP_NAME is set to execute the scan"
fi

if test -z "$CBAAS_KEY"
then
      CBAAS_KEY="nW8+U17qtebsd5j7"
      echo "\$$CBAAS_KEY is set to execute the scan on default key"
else
      echo "$CBAAS_KEY is set to execute the scan"
fi

if test -z "$CBAAS_VERSION"
then
    CBAAS_VERSION="2.4"
    echo "$CBAAS_VERSION is set to execute the scan on default version"
else
      echo "$CBAAS_VERSION is set to execute the scan"
fi

export baseurl="https://${APP_NAME}.lbg.eu-gb.mybluemix.net/swagger"

echo $baseurl
