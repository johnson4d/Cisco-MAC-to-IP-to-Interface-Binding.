#!/bin/bash
# 
# SCRIPT:  Cisco Switch/Router MAC-to-IP-Address-to-Interface binding.
# AUTHOR:  Darren Johnson
# VERSION: 1.0
# DATE: November 2016
#
# Variable to feed in all "host" MAC addresses. This variable not only filters on "DYNAMICALLY
# learned MAC addresses but also filters on just the interfaces that has only a single MAC
# address learned. This is to prevent the script showing a host IP address being on an interface
# when that interface is in fact a trunk interface to another switch.
maclist=`cat mac | grep  DYNAMIC | cut -c 38-52,9-22 | sort -k2 | uniq -f 1 -u | cut -d" " -f1`

# Hostname of device.
hostname=`cat arp | head -1 | cut -d"#" -f1`
echo `clear`
echo -e "\e[1m\e[97m\e[41m#######################################################################"
echo -e "Calculating MAC-to-IP-to-Interface Bindings on host device: $hostname"
echo -e "#######################################################################"
echo -e '\n'
echo -e "Please ensure the following files are in the same folder as this script:"
echo -e "Output of command 'show mac address-table' in file name <mac>"
echo -e "Output of command 'show arp' in file named <arp>"
echo -e '\n'
read -n 1 -s -p "Press any key to continue"
echo -e '\n\n'

for macaddress in $maclist;
do echo MAC Address $macaddress has IP address: `cat arp | grep $macaddress | cut -c 11-25 | { grep -v grep || echo "# No IP address in ARP cache! #" ;}` on Interface: `cat mac | grep $macaddress | cut -c 39-46`.;
done
echo -e '\n\n'
echo -e "Fun fact: Ants can accidentally misinterpret the chemical trails left by other ants and start walking in circles. If too many members of the colony join in, it can kill the whole colony in what is sometimes known as the 'Death Spiral'"
echo -e "\e[0m\n\n"

