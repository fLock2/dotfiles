# dotfiles

This is a dotfile chezmoi script based on [logandonley's config](https://github.com/logandonley/dotfiles).

This automated setup is currently only configured for MacOS machines.

This repo includes theming from other projects, so the download size will be big

## How to run

```shell (change "branch" to whatever distro is being used)
export GITHUB_USERNAME=fLock2
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --branch macos --apply $GITHUB_USERNAME
```
