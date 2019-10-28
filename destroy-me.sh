#!/bin/bash

API_KEY=${VULTR_API_KEY}
API_BASE_URL='https://api.vultr.com/v1'
FILTER_FIELD=tag
FILTER_VALUE=csgo
SERVER_DOMAIN='ferajna-csgo.duckdns.org'

if [ -z "${API_KEY}" ]
then
  echo "Missing VULTR_API_KEY env variable!"
  exit 1
fi


function vultr_get
{
  URL="${API_BASE_URL}$1"
  curl -s -H "API-Key: ${API_KEY}" ${URL}
}

echo "    > Listing machines..."

vultr_get "/server/list?${FILTER_FIELD}=${FILTER_VALUE}"

echo "    > Clearing server DNS..."

curl -s "https://www.duckdns.org/update?domains=${SERVER_DOMAIN}&token=${DUCKDNS_KEY}&clear=true"


# curl -H "API-Key: YIXFTXHFCGHUGB4J2X6N5I6FGDF7YPU5I3OQ"  "https://api.vultr.com/v1/server/list"