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

# Allow sub control group to control memory, cpu and pids
echo "+memory +cpu +pids" > /sys/fs/cgroup/cgroup.subtree_control;

# Create control group, they do not persist after reboot by default
mkdir -p /sys/fs/cgroup/container-view/container1;

# Allow sub control group to control memory, cpu and pids
echo "+memory +cpu +pids" > /sys/fs/cgroup/container-view/cgroup.subtree_control;

# Add values for control group
echo "500m" > /sys/fs/cgroup/container-view/container1/memory.max;
echo "50000 200000" > /sys/fs/cgroup/container-view/container1/cpu.max;
echo "0" > /sys/fs/cgroup/container-view/container1/memory.swap.max;
echo $$ > /sys/fs/cgroup/container-view/container1/cgroup.procs;

    ##################
   ##                ##
  ###   namespaces   ###
   ##                ##
    ##################

unshare --time --uts --pid --mount --mount-proc --ipc --net --cgroup --fork /bin/bash;
