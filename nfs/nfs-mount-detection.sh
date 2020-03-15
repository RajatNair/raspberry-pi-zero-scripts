#!/bin/bash

#
# This script will periodically check NFS mounts are up or not. If its not up
# it will mount them for you.
# Example - My Pi Zero will not mount my NFS drives at boot. This script
# will make sure that the drive is mounted. 
#

#
# Usage - 
# Edit Cron using 
# crontab -e
# Add following to run NFS detection every hour
# 0 \* \* \* \* /opt/nfs-mount-detection/nfs-mount-detection.sh 

if [ $UID -ne 0 ]; then
  echo "warning: this script was designed for root user."
  exit 1
fi

# Change your mountpoint according to your requirement
ISMOUNTED=`df -k | grep /mnt | wc -l`
if [ $ISMOUNTED = 0 ]; then
   date >> /var/log/messages
   echo NFS mounts down >> /var/log/messages
   echo Re-mounting all drives >> /var/log/messages
   sleep 5
   # mount -a will mount drives from /etc/fstab
   /bin/mount -a
   sleep 10
fi
