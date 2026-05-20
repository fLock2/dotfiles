#!/bin/bash

sudo tee /etc/systemd/user/vdirsyncer.service << EOF
[Unit]
Description=Synchronize calendars and contacts
Documentation=https://vdirsyncer.readthedocs.org/
StartLimitBurst=2

[Service]
ExecStart=$(which vdirsyncer) sync
RuntimeMaxSec=3m
Restart=on-failure
EOF

sudo tee /etc/systemd/user/vdirsyncer.timer << EOF
[Unit]
Description=Synchronize vdirs

[Timer]
OnBootSec=5m
OnUnitActiveSec=15m
AccuracySec=5m

[Install]
WantedBy=timers.target
EOF

sudo systemctl daemon-reload

#systemctl --user enable vdirsyncer.timer
#systemctl --user start vdirsyncer.timer
