#!/bin/bash

   #######      ###       ###     (IN DEVELOPMENT)
  #########      ###     ###
  ###             ###   ###       [Container View] Pivot root shell script
  ###              ### ###        Run script after create-container.sh script
  #########   ###   #####   ###
   #######    ###    ###    ###

cd /root/container-view-research/bash/rootfs;

mkdir /root/container-view-research/bash/rootfs/old_root;

mount --bind /root/container-view-research/bash/rootfs /root/container-view-research/bash/rootfs;

cd /root/container-view-research/bash/rootfs;

pivot_root . ./old_root;

cd /;

mount -t proc proc /proc;

umount -l old_root;

rm -r /old_root;
