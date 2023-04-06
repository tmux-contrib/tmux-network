#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=1090
source "${CURRENT_DIR}/scripts/helpers.sh"

# shellcheck disable=1090
net_public_ip="#(${CURRENT_DIR}/scripts/network.sh get-public-ip)"
net_public_ip_pattern="\#{net_public_ip}"

# shellcheck disable=1090
net_private_ip="#(${CURRENT_DIR}/scripts/network.sh get-private-ip)"
net_private_ip_pattern="\#{net_private_ip}"

tmux_interpolate() {
	local content="$1"

	content="${content/$net_public_ip_pattern/$net_public_ip}"
	content="${content/$net_private_ip_pattern/$net_private_ip}"

	echo "$content"
}

tmux_update_option() {
	local option="$1"
	local option_value

	option_value="$(tmux_get_option "$option")"
	option_value="$(tmux_interpolate "$option_value")"

	tmux_set_option "$option" "$option_value"
}

main() {
	tmux_update_option "status-right"
	tmux_update_option "status-left"
}

main
