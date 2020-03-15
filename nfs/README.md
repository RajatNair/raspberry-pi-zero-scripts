Sample `/etc/fstab`

```
proc            /proc           proc    defaults          0       0
PARTUUID=3111cca2-01  /boot           vfat    defaults          0       2
PARTUUID=3111cca2-02  /               ext4    defaults,noatime  0       1
# a swapfile is not a swap partition, no line here
#   use  dphys-swapfile swap[on|off]  for that
### Working NFS ###
192.168.2.58:/mnt/SeedboxA/ /mnt/SeedboxA/  nfs noatime,nofail,nolock,x-systemd.automount,x-systemd.device-timeout=15  0  0
## Samba
//192.168.2.3/SeedboxB/  /mnt/SeedboxB/       cifs   uid=1002,gid=1000,rw,username=user,password=password,vers=3.0,file_mode=0777,dir_mode=0777      0       0
```
