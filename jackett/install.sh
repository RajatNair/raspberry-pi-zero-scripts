#!/bin/bash
### Script to install and setup Jackett on Raspberry Pi Zero running Raspbian 9 (stretch)
### maintained by Aunlead

sudo apt update && sudo apt install libcurl4-openssl-dev mono-complete
cd /opt
sudo curl -L -O $( curl -s https://api.github.com/repos/Jackett/Jackett/releases | grep Jackett.Binaries.Mono.tar.gz | grep browser_download_url | head -1 | cut -d \" -f 4 )
sudo tar -xvzf Jackett*.tar.gz
sudo rm Jackett*.tar.gz
sudo chown -R $(whoami):$(whoami) /opt/Jackett


sudo tee /etc/systemd/system/jackett.service <<-'EOF'
[Unit]
Description="Jackett Daemon"
After=syslog.target network.target
[Service]
Environment=MONO_THREADS_PER_CPU="250",MONO_GC_PARAMS="nursery-size=256m"
MemoryMax=256M
WorkingDirectory=/opt/Jackett/
User=aunlead
Group=aunlead
ExecStart=/usr/bin/mono --optimize=all /opt/Jackett/JackettConsole.exe --NoRestart
KillMode=process
Restart=on-failure
Restart-sec=2
Type=simple
TimeoutStopSec=20
SyslogIdentifier=jackett
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload \
&& sudo systemctl enable /etc/systemd/system/jackett.service  \
&& sudo systemctl start jackett  \
&& sudo systemctl status jackett


echo 'Setting up firewall rules'
echo 'NOTE - Current firewall rules restricts IP range to 192.168.0.0/16'
sudo ufw allow from 192.168.0.0/16  to any port 9117
sudo ufw limit 9117 comment 'Jackett port'

echo 'Setup complete. Connect using localhost:9117'

