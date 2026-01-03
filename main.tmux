#!/usr/bin/env bash

# tmux-network plugin entry point.
#
# This plugin provides format strings for displaying network IP addresses
# in the tmux status bar.
#
# Usage:
#   Add #{net_public_ip} or #{net_private_ip} to your status-left or status-right option.
#
# Example:
#   set -g status-right "#{net_private_ip} | %H:%M"

_tmux_network_root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=scripts/tmux_network_core.sh
source "$_tmux_network_root_dir/scripts/tmux_network_core.sh"

net_public_ip="#($_tmux_network_root_dir/scripts/tmux_network.sh get-public-ip)"
net_public_ip_pattern="\#{net_public_ip}"

net_private_ip="#($_tmux_network_root_dir/scripts/tmux_network.sh get-private-ip)"
net_private_ip_pattern="\#{net_private_ip}"

# Interpolate network IP patterns in content.
#
# Replaces #{net_public_ip} and #{net_private_ip} patterns in the given
# content string with the actual tmux command strings to retrieve IP addresses.
#
# Globals:
#   net_public_ip - The tmux command string to get public IP
#   net_public_ip_pattern - The pattern to replace (#{net_public_ip})
#   net_private_ip - The tmux command string to get private IP
#   net_private_ip_pattern - The pattern to replace (#{net_private_ip})
# Arguments:
#   $1 - The content string containing the patterns
# Outputs:
#   The content with patterns replaced by tmux command strings
# Returns:
#   0 on success
tmux_interpolate() {
	local content="$1"

	content="${content/$net_public_ip_pattern/$net_public_ip}"
	content="${content/$net_private_ip_pattern/$net_private_ip}"

	echo "$content"
}

# Update a tmux option by interpolating network IP patterns.
#
# Retrieves the current value of the specified tmux option, replaces any
# occurrences of #{net_public_ip} and #{net_private_ip} with the actual
# command strings, and sets the option to the new value.
#
# Globals:
#   None
# Arguments:
#   $1 - The name of the tmux option to update (e.g., "status-right")
# Returns:
#   0 on success
tmux_update_option() {
	local option="$1"
	local option_value

	option_value="$(tmux_get_option "$option")"
	option_value="$(tmux_interpolate "$option_value")"

	tmux_set_option "$option" "$option_value"
}

# Main entry point for the plugin.
#
# Initializes the network plugin by updating the status-right and status-left
# options to interpolate the network IP patterns.
#
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   0 on success
main() {
	tmux_update_option "status-right"
	tmux_update_option "status-left"
}

main
