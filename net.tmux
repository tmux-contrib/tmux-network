#!/bin/bash -x

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

NET_PUBLIC_IP="#($CURRENT_DIR/script/public_ip.tmux)"
NET_PUBLIC_IP_INTERPOLATION_STRING="\\#{net_public_ip}"

NET_PRIVATE_IP="#($CURRENT_DIR/script/private_ip.tmux)"
NET_PRIVATE_IP_INTERPOLATION_STRING="\\#{net_private_ip}"

# shellcheck disable=1090
source "${CURRENT_DIR}/script/util.sh"

do_interpolation() {
  local text="$1"

  text="${text/$NET_PUBLIC_IP_INTERPOLATION_STRING/$NET_PUBLIC_IP}"
  text="${text/$NET_PRIVATE_IP_INTERPOLATION_STRING/$NET_PRIVATE_IP}"

  echo "$text"
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
