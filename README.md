# tmux-network

[![Test](https://github.com/tmux-contrib/tmux-network/actions/workflows/test.yml/badge.svg)](https://github.com/tmux-contrib/tmux-network/actions/workflows/test.yml) [![Release](https://img.shields.io/github/v/release/tmux-contrib/tmux-network)](https://github.com/tmux-contrib/tmux-network/releases) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Display your public and private IP addresses in the tmux status bar.

## Installation

Add this plugin to your `~/.tmux.conf`:

```tmux
set -g @plugin 'tmux-contrib/tmux-network'
```

And install it by running `<prefix> + I`.

## Usage

Add the format strings to your status bar:

```tmux
set -g status-right "#{network_private_ip} | #{network_public_ip}"
```

### Format Strings

| Format String           | Description                              |
|-------------------------|------------------------------------------|
| `#{network_public_ip}`  | Public IP address (from ip-api.com)      |
| `#{network_private_ip}` | Private IP address (from en0 interface)  |

## Development

### Prerequisites

Install dependencies using [Nix](https://nixos.org/):

```sh
nix develop
```

Or install manually: `bash`, `tmux`, `bats`

### Running Tests

```sh
bats tests/
```

### Debugging

Enable trace output with the `DEBUG` environment variable:

```sh
DEBUG=1 /path/to/tmux-network/scripts/tmux_network.sh get-public-ip
```

## License

MIT
