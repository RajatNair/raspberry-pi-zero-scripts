#!/bin/bash
### Script to install and setup Bazarr on Raspberry Pi Zero running Raspbian 9 (stretch)
### maintained by Aunlead

#sudo apt update && sudo apt install git-core python-pip
cd /opt
sudo git clone https://github.com/morpheus65535/bazarr.git
sudo chown -R $(whoami):$(whoami) /opt/bazarr


sudo tee /etc/systemd/system/bazarr.service <<-'EOF'
[Unit]
Description="Bazarr Daemon"
After=syslog.target network.target
[Service]
User=aunlead
Group=aunlead
ExecStart=/usr/bin/python /opt/bazarr/bazarr.py
KillMode=process
Restart=on-failure
Restart-sec=2
Type=simple
TimeoutStopSec=20
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload \
&& sudo systemctl enable /etc/systemd/system/bazarr.service  \
&& sudo systemctl start bazarr  \
&& sudo systemctl status bazarr


echo 'Setting up firewall rules'
echo 'NOTE - Current firewall rules restricts IP range to 192.168.0.0/16'
sudo ufw allow from 192.168.0.0/16  to any port 6767
sudo ufw limit 6767 comment 'bazarr port'

echo 'Setup complete. Connect using localhost:6767'

