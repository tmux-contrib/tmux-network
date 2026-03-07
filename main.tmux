#!/usr/bin/env bash
set -euo pipefail
[[ -z "${DEBUG:-}" ]] || set -x

_tmux_network_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

[[ -f "$_tmux_network_root/scripts/tmux_core.sh" ]] || {
	echo "tmux-network: missing tmux_core.sh" >&2
	exit 1
}

# shellcheck source=scripts/tmux_core.sh
source "$_tmux_network_root/scripts/tmux_core.sh"

network_public_ip="#($_tmux_network_root/scripts/tmux_network.sh get-public-ip)"
network_public_ip_pattern="\#{network_public_ip}"

network_private_ip="#($_tmux_network_root/scripts/tmux_network.sh get-private-ip)"
network_private_ip_pattern="\#{network_private_ip}"

_tmux_interpolate() {
	local content=$1
	local pattern=$2
	local value=$3

	echo "${content/$pattern/$value}"
}

_tmux_update_option() {
	local option="$1"
	local option_value

	option_value="$(_tmux_get_option "$option")"
	option_value="$(_tmux_interpolate "$option_value" "$network_public_ip_pattern" "$network_public_ip")"
	option_value="$(_tmux_interpolate "$option_value" "$network_private_ip_pattern" "$network_private_ip")"

	_tmux_set_option "$option" "$option_value"
}

main() {
	_tmux_update_option "status-right"
	_tmux_update_option "status-left"
}

main
