#!/bin/bash

   #######      ###       ###     (IN DEVELOPMENT)
  #########      ###     ###
  ###             ###   ###       [Container View]
  ###              ### ###        Shell script to setup cgroup and namespaces
  #########   ###   #####   ###   Run this script first!
   #######    ###    ###    ###



    ##################
   ##                ##
  ###   cgroups v2   ###
   ##                ##
    ##################

# Create control group, they do not persist after reboot by default
cgcreate -g cpu,memory:/container-view;

# Cannot edit write to files in /sys/fs/cgroup with text editer
# Using the tool
cgset -r cpu.max="10000 100000" container-view;
cgset -r memory.max="500M" container-view;
cgset -r memory.swap.max="0" container-view;

cd /root/container-view-research/bash;

   ##################
  ##                ##
 ###   namespaces   ###
  ##                ##
   ##################

unshare --uts --pid --mount --mount-proc --net --ipc --cgroup --fork /bin/bash;
