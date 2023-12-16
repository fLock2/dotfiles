# dotfiles
This is a dotfile chezmoi script based on [logandonley's config](https://raw.githubusercontent.com/logandonley/dotfiles).

This automated setup is currently only configured for Fedora machines.

## How to run

```shell
export GITHUB_USERNAME=fLock2
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

