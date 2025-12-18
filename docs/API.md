# tmux-network API Documentation

This document describes the public API for the tmux-network plugin.

## Table of Contents

- [Overview](#overview)
- [Format Strings](#format-strings)
- [Core Functions](#core-functions)
  - [tmux_get_option](#tmux_get_option)
  - [tmux_set_option](#tmux_set_option)
- [Plugin Functions](#plugin-functions)
  - [main (tmux-network.sh)](#main-tmux-networksh)
  - [tmux_interpolate](#tmux_interpolate)
  - [tmux_update_option](#tmux_update_option)

---

## Overview

The tmux-network plugin displays network IP addresses in the tmux status bar.
It provides both public (external) and private (local) IP address information.

## Format Strings

| Format String      | Description                                    |
|--------------------|------------------------------------------------|
| `#{net_public_ip}` | Public IP address (fetched from ip-api.com)    |
| `#{net_private_ip}`| Private IP address (from en0 interface)        |

**Usage Example:**
```tmux
set -g status-right "#{net_private_ip} | #{net_public_ip}"
```

---

## Core Functions

Located in `scripts/core.sh`.

### tmux_get_option

Get a tmux option value.

Retrieves the value of a global tmux option. If the option is not set,
returns the provided default value.

```bash
tmux_get_option "option_name" "default_value"
```

**Arguments:**
- `$1` - The name of the tmux option to retrieve
- `$2` - The default value to return if the option is not set

**Outputs:**
- The option value or default value to stdout

**Returns:**
- `0` on success

---

### tmux_set_option

Set a tmux option value.

Sets a global tmux option to the specified value.

```bash
tmux_set_option "option_name" "value"
```

**Arguments:**
- `$1` - The name of the tmux option to set
- `$2` - The value to set the option to

**Returns:**
- `0` on success, non-zero on failure

---

## Plugin Functions

### main (tmux-network.sh)

Located in `scripts/tmux-network.sh`.

Get network IP address information.

Retrieves either the public or private IP address based on the command
argument provided.

```bash
# Get public IP
./scripts/tmux-network.sh get-public-ip
# Output: "203.0.113.42"

# Get private IP
./scripts/tmux-network.sh get-private-ip
# Output: "192.168.1.100"
```

**Arguments:**
- `$1` - The command to execute:
  - `get-public-ip` - Fetch public IP from ip-api.com
  - `get-private-ip` - Get local private IP from en0 interface

**Outputs:**
- The IP address to stdout

**Returns:**
- `0` on success

**Dependencies:**
- `get-public-ip`: `curl`, `jq`
- `get-private-ip`: `ipconfig` (macOS)

---

### tmux_interpolate

Located in `main.tmux`.

Interpolate network IP patterns in content.

Replaces `#{net_public_ip}` and `#{net_private_ip}` patterns in the given
content string with the actual tmux command strings to retrieve IP addresses.

```bash
tmux_interpolate "IP: #{net_public_ip}"
# Output: "IP: #(/path/to/scripts/tmux-network.sh get-public-ip)"
```

**Arguments:**
- `$1` - The content string containing the patterns

**Outputs:**
- The content with patterns replaced by tmux command strings

**Returns:**
- `0` on success

---

### tmux_update_option

Located in `main.tmux`.

Update a tmux option by interpolating network IP patterns.

Retrieves the current value of the specified tmux option, replaces any
occurrences of `#{net_public_ip}` and `#{net_private_ip}` with the actual
command strings, and sets the option to the new value.

```bash
tmux_update_option "status-right"
```

**Arguments:**
- `$1` - The name of the tmux option to update (e.g., "status-right")

**Returns:**
- `0` on success
