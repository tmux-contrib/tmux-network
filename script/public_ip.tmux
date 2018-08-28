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

   PUBLIC_IP_DATA=$(fetch_ip_data)
   PUBLIC_IP_ADDRESS=$(echo "$PUBLIC_IP_DATA" | jq -r .query)

   echo "$PUBLIC_IP_ADDRESS"
}

main
