#!/bin/bash

   #######      ###       ###     (IN DEVELOPMENT)
  #########      ###     ###
  ###             ###   ###       [Container View]
  ###              ### ###        Pivot root shell script
  #########   ###   #####   ###   Run script after cgroup-namespace.sh script
   #######    ###    ###    ###



mkdir /container/container1/old_root;

mount --bind /container/container1 /container/container1;

pivot_root /container/container1 /container/container1/old_root;

cd /;

mount -t proc proc /proc;

umount -l old_root;

rm -r /old_root;
