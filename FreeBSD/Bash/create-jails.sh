#!/usr/local/bin/bash
#
# VERY OLD SCRIPT, NEEDS TESTING
#
# Bash Variables
zroot=$1
ipv4=$2
#
if [ -z "$1" ] || [ -z "$2" ] 
then
echo "\$1 and/or \$2 is empty
\$1 = the name of the zfs pool, default is zroot
\$2 = the first digit in the 4th ipv4 octet";          
else
#
# Get base.txz
mount -t cd9660 /dev/cd0 /media/ ;
cp /media/usr/freebsd-dist/base.txz /root ;
umount /media ;
#
# Create zfs datasets
zfs create $zroot/jails ;
zfs create $zroot/jails/asterisk ;
zfs create $zroot/jails/dns ;
zfs create $zroot/jails/go ;
zfs create $zroot/jails/grafana ;
zfs create $zroot/jails/mysql ;
zfs create $zroot/jails/firewall ;
zfs create $zroot/jails/spare ;
#
# Untar base.txz in each jail
tar -xf /root/base.txz -C /$zroot/jails/asterisk/ ;
tar -xf /root/base.txz -C /$zroot/jails/dns/ ;
tar -xf /root/base.txz -C /$zroot/jails/go/ ;
tar -xf /root/base.txz -C /$zroot/jails/grafana/ ;
tar -xf /root/base.txz -C /$zroot/jails/mysql/ ;
tar -xf /root/base.txz -C /$zroot/jails/firewall/ ;
tar -xf /root/base.txz -C /$zroot/jails/spare/ ;
#
# Create rc.conf for asterisk jail.
printf '%s\n' \
'ifconfig_epair1b="inet 192.168.0.'$ipv4'1 netmask 255.255.255.0"' \
'defaultrouter="192.168.0.1"' \
'ifconfig_epair101b_ipv6="inet6 fc00::1 prefixlen 124"' \
'sendmail_enable="NO"' \
'sendmail_submit_enable="NO"' \
'sendmail_outbound_enable="NO"' \
'sendmail_msp_queue_enable="NO"' \
> /$zroot/jails/asterisk/etc/rc.conf ;
#
# Create rc.conf for dns jail.
printf '%s\n' \
'ifconfig_epair2b="inet 192.168.0.53 netmask 255.255.255.0"' \
'defaultrouter="192.168.0.1"' \
'sendmail_enable="NO"' \
'sendmail_submit_enable="NO"' \
'sendmail_outbound_enable="NO"' \
'sendmail_msp_queue_enable="NO"' \
> /$zroot/jails/dns/etc/rc.conf ;
#
# Create rc.conf for go jail.
printf '%s\n' \
   'ifconfig_epair3b="inet 192.168.0.'$ipv4'3 netmask 255.255.255.0"' \
   'defaultrouter="192.168.0.1"' \
   'ifconfig_epair103b_ipv6="inet6 fc00::3 prefixlen 124"' \
   'sendmail_enable="NO"' \
   'sendmail_submit_enable="NO"' \
   'sendmail_outbound_enable="NO"' \
   'sendmail_msp_queue_enable="NO"' \
> /$zroot/jails/go/etc/rc.conf ;
#
# Create rc.conf for grafana jail.
printf '%s\n' \
   'ifconfig_epair4b="inet 192.168.0.'$ipv4'4 netmask 255.255.255.0"' \
   'defaultrouter="192.168.0.1"' \
   'ifconfig_epair104b_ipv6="inet6 fc00::4 prefixlen 124"' \
   'sendmail_enable="NO"' \
   'sendmail_submit_enable="NO"' \
   'sendmail_outbound_enable="NO"' \
   'sendmail_msp_queue_enable="NO"' \
> /$zroot/jails/grafana/etc/rc.conf ;
#
# Create rc.conf for mysql jail.
printf '%s\n' \
   'ifconfig_epair5b="inet 192.168.0.'$ipv4'5 netmask 255.255.255.0"' \
   'defaultrouter="192.168.0.1"' \
   'ifconfig_epair105b_ipv6="inet6 fc00::5 prefixlen 124"' \
   'sendmail_enable="NO"' \
   'sendmail_submit_enable="NO"' \
   'sendmail_outbound_enable="NO"' \
   'sendmail_msp_queue_enable="NO"' \
> /$zroot/jails/mysql/etc/rc.conf ;
#
# Create rc.conf for firewall jail.
printf '%s\n' \
   'ifconfig_epair6b="inet 192.168.0.'$ipv4'6 netmask 255.255.255.0"' \
   'defaultrouter="192.168.0.1"' \
   'ifconfig_epair106b_ipv6="inet6 fc00::6 prefixlen 124"' \
   'sendmail_enable="NO"' \
   'sendmail_submit_enable="NO"' \
   'sendmail_outbound_enable="NO"' \
   'sendmail_msp_queue_enable="NO"' \
> /$zroot/jails/firewall/etc/rc.conf ;
#
# Create rc.conf for spare jail.
printf '%s\n' \
   'ifconfig_epair7b="inet 192.168.0.'$ipv4'7 netmask 255.255.255.0"' \
   'defaultrouter="192.168.0.1"' \
   'ifconfig_epair107b_ipv6="inet6 fc00::7 prefixlen 124"' \
   'sendmail_enable="NO"' \
   'sendmail_submit_enable="NO"' \
   'sendmail_outbound_enable="NO"' \
   'sendmail_msp_queue_enable="NO"' \
> /$zroot/jails/spare/etc/rc.conf ;
#
# Create resolv.conf for each jail.
printf '%s\n' \
   'nameserver 192.168.0.1' \
> /$zroot/jails/asterisk/etc/resolv.conf;
printf '%s\n' \
   'nameserver 192.168.0.1' \
> /$zroot/jails/dns/etc/resolv.conf;
printf '%s\n' \
   'nameserver 192.168.0.1' \
> /$zroot/jails/go/etc/resolv.conf;
printf '%s\n' \
   'nameserver 192.168.0.1' \
> /$zroot/jails/grafana/etc/resolv.conf;
printf '%s\n' \
   'nameserver 192.168.0.1' \
> /$zroot/jails/mysql/etc/resolv.conf;
printf '%s\n' \
   'nameserver 192.168.0.1' \
> /$zroot/jails/firewall/etc/resolv.conf;
printf '%s\n' \
   'nameserver 192.168.0.1' \
> /$zroot/jails/spare/etc/resolv.conf;
fi
