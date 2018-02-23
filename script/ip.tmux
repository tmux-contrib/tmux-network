#!/bin/bash

if ! which jq &> /dev/null; then
   log "ipinfo" "jq is not installed"
   exit 1
fi

IP_DATA=$(curl -s http://ip-api.com/json)
IP_ADDRESS=$(echo "$IP_DATA" | jq -r .query)

echo "$IP_ADDRESS"

