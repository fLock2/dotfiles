#!/bin/sh

# exit immediately if password-manager-binary is already in $PATH
type op >/dev/null 2>&1 && exit

case "$(uname -s)" in
Darwin)
    # commands to install password-manager-binary on Darwin
    ;;
Linux)
    # commands to install password-manager-binary on Linux
    sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
    sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
    sudo dnf install 1password -y

    sudo dnf install coreutils unzip -y
    ARCH=$(arch) && \
    wget "https://cache.agilebits.com/dist/1P/op2/pkg/v2.33.1/op_linux_${ARCH}_v2.33.1.zip" -O op.zip && \
    unzip -d op op.zip && \
    sudo mv op/op /usr/local/bin/ && \
    rm -r op.zip op && \
    sudo groupadd -f onepassword-cli && \
    sudo chgrp onepassword-cli /usr/local/bin/op && \
    sudo chmod g+s /usr/local/bin/op
    ;;
*)
    echo "unsupported OS"
    exit 1
    ;;
esac
