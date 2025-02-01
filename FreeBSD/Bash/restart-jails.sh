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
########################
## Create jail epairs ##
########################
ifconfig epair1 create;
ifconfig epair2 create;
ifconfig epair3 create;
ifconfig epair4 create;
ifconfig epair5 create;
ifconfig epair6 create;
ifconfig epair7 create;
ifconfig epair101 create;
ifconfig epair103 create;
ifconfig epair104 create;
ifconfig epair105 create;
ifconfig epair106 create;
ifconfig epair107 create;
ifconfig epair206 create;
#################################
## Add jails to Public bridge1 ##
#################################
ifconfig bridge1 addm epair1a;
ifconfig bridge1 addm epair2a;
ifconfig bridge1 addm epair3a;
ifconfig bridge1 addm epair4a;
ifconfig bridge1 addm epair5a;
ifconfig bridge1 addm epair6a;
ifconfig bridge1 addm epair7a;
ifconfig epair1a up;
ifconfig epair2a up;
ifconfig epair3a up;
ifconfig epair4a up;
ifconfig epair5a up;
ifconfig epair6a up;
ifconfig epair7a up;
ifconfig bridge1 up;
##################################
## Add jails to Private bridge2 ##
##################################
ifconfig bridge2 addm epair101a;
ifconfig bridge2 addm epair103a;
ifconfig bridge2 addm epair104a;
ifconfig bridge2 addm epair105a;
ifconfig bridge2 addm epair106a;
ifconfig bridge2 addm epair107a;
ifconfig epair101a up;
ifconfig epair103a up;
ifconfig epair104a up;
ifconfig epair105a up;
ifconfig epair106a up;
ifconfig epair107a up;
ifconfig bridge2 up;
#################################
## Add jails to router bridge3 ##
#################################
ifconfig bridge3 addm epair206a;
ifconfig epair206a up;
ifconfig bridge3 up;
#################
## Start jails ##
#################
service jail onestart;
