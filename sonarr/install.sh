#!/bin/bash
### Script to install and setup Sonarr on Raspberry Pi Zero running Raspbian 9 (stretch)
### maintained by Aunlead

# Run updates
# sudo apt-get update &&  sudo apt-get upgrade -y
sudo apt-get install libmono-cil-dev -y
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC
echo "deb http://apt.sonarr.tv/ master main" | sudo tee /etc/apt/sources.list.d/sonarr.list
sudo apt-get update && sudo apt-get install nzbdrone
sudo chown -R aunlead:aunlead /opt/NzbDrone


sudo tee /etc/systemd/system/sonarr.service <<-'EOF'
[Unit]
Description="Sonarr Daemon"
After=syslog.target network.target
[Service]
User=aunlead
Group=aunlead
Type=simple
ExecStart=/usr/bin/mono /opt/NzbDrone/NzbDrone.exe -nobrowser -data=/home/aunlead/sonarr
TimeoutStopSec=20
KillMode=process
Restart=on-failure
Restart-sec=2
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload \
&& sudo systemctl enable /etc/systemd/system/sonarr.service  \
&& sudo systemctl start sonarr  \
&& sudo systemctl status sonarr 


echo 'Setting up firewall rules'
echo 'NOTE - Current firewall rules restricts IP range to 192.168.0.0/16'
sudo ufw allow from 192.168.0.0/16  to any port 8989
sudo ufw limit 8989 comment 'Sonarr port'

echo 'Setup complete. Connect using localhost:8989'
