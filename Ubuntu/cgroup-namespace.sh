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
cgcreate -g cpu,memory:/container-view/container1;

# Cannot edit write to files in /sys/fs/cgroup with text editer
# Using the tool 
cgset -r cgroup.subtree_control="+memory +cpu" container-view;
cgset -r cpu.max="10000 100000" container-view/container1;
cgset -r memory.max="500M" container-view/container1;
cgset -r memory.swap.max="0" container-view/container1;
cgset -r cgroup.procs=$pid container-view/container1;

    ##################
   ##                ##
  ###   namespaces   ###
   ##                ##
    ##################

unshare --time --uts --pid --mount --mount-proc --ipc --net --cgroup --fork /bin/bash;
