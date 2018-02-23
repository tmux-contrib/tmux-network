#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

NET_IP="#($CURRENT_DIR/script/ip.tmux)"
NET_IP_INTERPOLATION_STRING="\\#{net_ip}"

# shellcheck disable=1090
source "${CURRENT_DIR}/script/util.sh"

do_interpolation() {
  local string="$1"
  local interpolated="${string/$NET_IP_INTERPOLATION_STRING/$NET_IP}"

  echo "$interpolated"
}

update_tmux_option() {
  local option="$1"
  local option_value
  local new_option_value

  option_value="$(get_tmux_option "$option")"
  new_option_value="$(do_interpolation "$option_value")"

  set_tmux_option "$option" "$new_option_value"
}

update_tmux_option "status-right"
update_tmux_option "status-left"
