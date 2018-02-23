tmux-net
===========

This is a mini plugin for [TPM](https://github.com/tmux-plugins/tpm).

This plugin just display current IP address. Only do it.

## Usage

Add `#{net_ip}` format string to your existing status-right tmux option.

```shell
set-option -g status-right '#{net_ip}'
```

## Install

You can install the plugin via tpm by adding the following line in your
`.tmux.conf` file:

```shell
set -g @plugin 'svett/tmux-net'
```

[Detailed Installation Guidelines](https://github.com/tmux-plugins/tpm#installation)

## LICENSE

[MIT](https://github.com/svett/tmux-ip/blob/master/LICENSE.md)


