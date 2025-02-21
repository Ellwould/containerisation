#!/bin/bash

# A script to be run inside the container to configure 
# the other VETH endpoint and routing table

# Run after network-outside-container.sh

ifconfig lo up;

ifconfig ethPair1b $containerIPv4 netmask $containerMask up;

route add default gw $containerGateway ethPair1b;

ifconfig ethPair1b up;
