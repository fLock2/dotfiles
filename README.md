# dotfiles
This is a dotfile chezmoi script based on [logandonley's config](https://raw.githubusercontent.com/logandonley/dotfiles).

This automated setup is currently only configured for MacOS machines.

This repo includes theming from other projects, so the download size will be big
## How to run

```shell (currently runs fedora setup, need to update)
export GITHUB_USERNAME=fLock2
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

