#!/bin/bash
### Script to install and setup Radarr on Raspberry Pi Zero running Raspbian 9 (stretch)
### maintained by Aunlead

sudo apt update && sudo apt install libmono-cil-dev curl mediainfo mono-complete
cd /opt
sudo curl -L -O $( curl -s https://api.github.com/repos/Radarr/Radarr/releases | grep linux.tar.gz | grep browser_download_url | head -1 | cut -d \" -f 4 )
sudo tar -xvzf Radarr.*.linux.tar.gz
sudo rm Radarr.*.linux.tar.gz
sudo chown -R $(whoami):$(whoami) /opt/Radarr


sudo tee /etc/systemd/system/radarr.service <<-'EOF'
[Unit]
Description="Radarr Daemon"
After=syslog.target network.target
[Service]
User=aunlead
Group=aunlead
Type=simple
ExecStart=/usr/bin/mono /opt/Radarr/Radarr.exe -nobrowser -data=/home/aunlead/radarr
TimeoutStopSec=20
KillMode=process
Restart=on-failure
Restart-sec=2
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload \
&& sudo systemctl enable /etc/systemd/system/radarr.service  \
&& sudo systemctl start radarr  \
&& sudo systemctl status radarr 


echo 'Setting up firewall rules'
echo 'NOTE - Current firewall rules restricts IP range to 192.168.0.0/16'
sudo ufw allow from 192.168.0.0/16  to any port 7878
sudo ufw limit 7878 comment 'Radarr port'

echo 'Setup complete. Connect using localhost:7878'
