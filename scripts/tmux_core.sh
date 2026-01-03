#!/usr/bin/env bash

# Get a tmux option value.
#
# Retrieves the value of a global tmux option. If the option is not set,
# returns the provided default value.
#
# Globals:
#   None
# Arguments:
#   $1 - The name of the tmux option to retrieve
#   $2 - The default value to return if the option is not set
# Outputs:
#   The option value or default value to stdout
# Returns:
#   0 on success
_tmux_get_option() {
	local option="$1"
	local default_value="$2"
	local option_value

	option_value="$(tmux show-option -gqv "$option")"
	[[ -n "$option_value" ]] && echo "$option_value" || echo "$default_value"
}

# Set a tmux option value.
#
# Sets a global tmux option to the specified value.
#
# Globals:
#   None
# Arguments:
#   $1 - The name of the tmux option to set
#   $2 - The value to set the option to
# Returns:
#   0 on success, non-zero on failure
_tmux_set_option() {
	local option="$1"
	local value="$2"

	tmux set-option -gq "$option" "$value"
}
