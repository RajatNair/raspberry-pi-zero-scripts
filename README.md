## Collection of BASH scripts for Raspberry Pi Zero which will -
###### 1. Harden Raspbian
###### 2. Install scripts to setup specific softwares

---

### Initial Setup
###### 1. SSH to odroid-ip:22 (Default username is _pi_ and password _raspberry_). 
Additional info here - https://www.raspberrypi.org/documentation/remote-access/ssh/unix.md

###### 2. Change pi password from default

###### 3. Change root user password from default

###### 3. Update Raspbian

###### 4. Change default SSH port and disable root login
```shell
## Lockdown - changing default ports
sudo nano /etc/ssh/sshd_config
## Disable root login
PermitRootLogin no
## Change default SSH port to any random port (eg. 2230)
Port 2230
## Lockdown - Firewall 
sudo ufw limit ssh/tcp
sudo ufw allow 2230/tcp
sudo systemctl reload sshd
```
