#!/bin/bash

# Get network IP address information.
#
# Retrieves either the public or private IP address based on the
# command argument provided.
#
# Globals:
#   None
# Arguments:
#   $1 - The command to execute:
#        "get-public-ip"  - Fetch public IP from ip-api.com
#        "get-private-ip" - Get local private IP from en0 interface
# Outputs:
#   The IP address to stdout
# Returns:
#   0 on success
# Dependencies:
#   - get-public-ip: curl, jq
#   - get-private-ip: ipconfig (macOS)
main() {
	if [[ "$1" == "get-public-ip" ]]; then
		curl -s http://ip-api.com/json | jq -r .query
	elif [[ "$1" = "get-private-ip" ]]; then
		ipconfig getifaddr en0
	fi
}

main "$@"
