#!/bin/bash
SERVICE_PATH=/etc/systemd/system/enviro-monitor.service

read -r -d '' UNIT_FILE << EOF
[Unit]
Description=Enviro+ monitor service
After=multi-user.target

[Service]
Type=simple
WorkingDirectory=$(pwd)
ExecStart=sudo python3 $(pwd)/enviro-monitor.py
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF



printf "\nInstalling service to: $SERVICE_PATH\n"
echo "$UNIT_FILE" > $SERVICE_PATH
systemctl daemon-reload
systemctl enable --no-pager enviro-monitor.service
systemctl restart --no-pager enviro-monitor.service
systemctl status --no-pager enviro-monitor.service
