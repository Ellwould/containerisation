# Containerisation

## A collection of various containerisation methods within FreeBSD Jails and GNU/Linux (Tested on Ubuntu 24.04 LTS)

<br>

## GNU/Linux (Tested on Ubuntu 24.04 LTS)

#### The /containerisation/Ubuntu/Bash directory contains Bash scripts for creating containers without utilising a container runtime

<br>

### Namespaces within the Linux Kernel :
- <b>Mount</b> first namespace created for the Linux Kernel, added to the Linux Kernal in version 2.4.19, can be used to control mount points within a container: https://man7.org/linux/man-pages/man7/mount_namespaces.7.html

<br>

- <b>UTS (UNIX Time-Sharing)</b> namespace added to the Linux Kernel in version 2.6.19, allows a separate hostname and NIS (Network Information Service) domain name in a container: https://man7.org/linux/man-pages/man7/uts_namespaces.7.html

<br>

- <b>IPC (Inter Process Communication)</b> namespace added to the Linux Kernel in version 2.6.19, can isolate various IPC's within a container: https://man7.org/linux/man-pages/man7/ipc_namespaces.7.html

<br>

- <b>PID (Process Identifier)</b> namespace added to the Linux Kernel in version 2.6.24, allows separate PID number space within a container: https://man7.org/linux/man-pages/man7/pid_namespaces.7.html

<br>

- <b>Network</b> namespace added to the Linux Kernel in version 2.6.19 and development carried on until approximately Linux Kernel version 2.6.29, can be used to allow a container to have isolated networking devices from the host OS; thus a container can have a separate IP address with layer 4 ports and a routing table: https://man7.org/linux/man-pages/man7/network_namespaces.7.html

<br>

- <b>User</b> namespace added to the Linux Kernel in version 2.6.23 and development carried on until approximately Linux Kernel version 3.8, can provide a container separate user and group identifier number space: https://man7.org/linux/man-pages/man7/user_namespaces.7.html

Source: Namespaces in operation, part 1: namespaces overview, Michael Kerrisk, https://lwn.net/Articles/531114/
<br>Definitely worth a read :)

<br>

- 
-
-
-

<br>

<b>Linux Kernel Namespaces information:</b> https://man7.org/linux/man-pages/man7/namespaces.7.html

<br>

<b>GNU/Linux unshare command:</b> https://man7.org/linux/man-pages/man1/unshare.1.html

<br>

<b>Linux Kernel cgroups information:</b> https://man7.org/linux/man-pages/man7/cgroups.7.html

<br>

<b>GNU/Linux cgcreate command:</b> https://manpages.ubuntu.com/manpages/oracular/man1/cgcreate.1.html

<br>

<b>GNU/Linux Pivot command:</b> https://man7.org/linux/man-pages/man8/pivot_root.8.html

<br>

## FreeBSD

The FreeBSD directory in this repository contains anything relevent to Jails, the infomation is old though and last tested on FreeBSD version 12.0-RELEASE-p10, Generic Kernel, ZFS, 64 bit

<br>

For up to date infomation please see the FreeBSD handbook: https://docs.freebsd.org/en/books/handbook/jails or the FreeBSD jails manual page: https://man.freebsd.org/cgi/man.cgi?jail(8)

<br>
<br>

For a list of abbreviations and there meanings used throughout this repository please refer to the README at: https://github.com/Ellwould/information_technology_and_telecommunication_abbreviations
