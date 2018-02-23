#!/bin/bash

check_dependencies() {
   if ! which jq &> /dev/null; then
      log "ipinfo" "jq is not installed"
      exit 1
   fi
}

fetch_ip_data() {
   curl -s http://ip-api.com/json
}

main() {
   check_dependencies

   IP_DATA=$(fetch_ip_data)
   IP_ADDRESS=$(echo "$IP_DATA" | jq -r .query)

   echo "$IP_ADDRESS"
}

main
