#!/usr/local/bin/bash
####################
## Destroy epairs ##
####################
ifconfig epair1a destroy;
ifconfig epair2a destroy;
ifconfig epair3a destroy;
ifconfig epair4a destroy;
ifconfig epair5a destroy;
ifconfig epair6a destroy;
ifconfig epair7a destroy;
ifconfig epair101a destroy;
ifconfig epair103a destroy;
ifconfig epair104a destroy;
ifconfig epair105a destroy;
ifconfig epair106a destroy;
ifconfig epair107a destroy;
ifconfig epair206a destroy;
################
## Stop jails ##
################
service jail onestop;
