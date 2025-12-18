# tmux-network

A tmux plugin that displays public and private IP addresses in the status bar.

## Features

- Display public IP address (via external API)
- Display private/local IP address
- Lightweight and simple to use

## Requirements

- `curl` and `jq` (for public IP lookup)
- `ipconfig` (macOS, for private IP)

## Installation

### Using TPM

Add the following line to your `~/.tmux.conf`:

```tmux
set -g @plugin 'tmux-contrib/tmux-network'
```

Then press `prefix` + <kbd>I</kbd> to install.

### Manual

Clone the repository:

```bash
git clone https://github.com/tmux-contrib/tmux-network ~/.tmux/plugins/tmux-network
```

Add to your `~/.tmux.conf`:

```tmux
run-shell ~/.tmux/plugins/tmux-network/main.tmux
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

## Documentation

See [docs/API.md](docs/API.md) for the full API documentation.

## License

[MIT](LICENSE)
