# tmux-network

A tmux plugin that displays public and private IP addresses in the status bar.

## Installation

```tmux
# configure the tmux plugins manager
set -g @plugin "tmux-plugins/tpm"

# official plugins
set -g @plugin 'tmux-contrib/tmux-network'
```

## Usage

Add the format strings to your status bar:

```tmux
set -g status-right "#{net_private_ip} | #{net_public_ip}"
```

### Format Strings

| Format String       | Description                              |
|---------------------|------------------------------------------|
| `#{net_public_ip}`  | Public IP address (from ip-api.com)      |
| `#{net_private_ip}` | Private IP address (from en0 interface)  |
