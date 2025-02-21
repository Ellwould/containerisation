#!/bin/bash

   #######      ###       ###     (IN DEVELOPMENT)
  #########      ###     ###
  ###             ###   ###       [Container View] Network Container shell script
  ###              ### ###        Run script after pivot-root-container.sh
  #########   ###   #####   ###
   #######    ###    ###    ###



    ###############################
   ##                             ##
  ###   Virtual Ethernet Device   ###
   ##                             ##
    ###############################

# Create Virtual Ethernet (VETH) device pair using the ip command
ip link add ethPair1a type veth peer name ethPair1b;


# Add the VETH device endpoint ethPair1b to the network namespace used by the container 
# and add the VETH device endpoint ethPair1a to the default network namespace used by the host 
# using the ip command.
ip link add ethPair1b netns $containerPid type veth peer name ethPair1a netns 1;

    ##############
   ##            ##
  ###   Bridge   ###
   ##            ##
    ##############

# Create a bridge on the host using the ip command
ip link add name br0 type bridge;

# Alternatively the brctl command could be used to create a bridge on the host
# brctl addbr br0;


# Enable Spanning Tree Protocol (STP) on the bridge using the ip command
ip link set br0 type bridge stp_state 1;

# Alternatively the brctl command could be used to enable Spanning Tree Protocol (STP) on the bridge
# brctl stp br0 on;


# Add the hosts secondary interface to bridge using the ip command
ip link set dev $hostInt master br0;

# Alternatively the brctl command could be used to add the hosts secondary interface to the bridge
# brctl addif br0 $hostInt;


# Add the VETH endpoint ethPair1a on the host to the bridge using the ip command
ip link set dev ethPair1a master br0;

# Alternatively the brctl command could be used to add the VETH device endpoint ethPair1a the to bridge
# brctl addif br0 ethPair1a;

    ###########################
   ##                         ##
  ###   Bring Interfaces Up   ###
   ##                         ##
    ###########################

# Bring the VETH endpoint ethPair1a up using the ip command
ip link set dev ethPair1a up;

# Alternatively bring the VETH endpoint ethPair1a up using the ifconfig command
# ifconfig ethPair1a up;


# Bring the hosts secondary interface up using the ip command
ip link set dev $hostInt up;

# Alternatively bring the hosts secondary interface up using the ifconfig command
# ifconfig $hostInt up;


# Bring the bridge br0 up using the ip command
ip link set dev br0 up;

# Alternatively bring the bridge br0 up using the ifconfig command
# ifconfig br0 up;
