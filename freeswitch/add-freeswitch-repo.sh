#!/bin/bash
# From: https://github.com/fusionpbx/fusionpbx-install.sh/blob/master/debian/resources/environment.sh

cpu_name=$(uname -m)
cpu_architecture='unknown'

if [ .$cpu_name = .'armv7l' ]; then
	# RaspberryPi 3 is actually armv8l but current Raspbian reports the cpu as armv7l and no Raspbian 64Bit has been released at this time
	cpu_architecture='arm'
elif [ .$cpu_name = .'armv8l' ]; then
	# We currently have no test case for armv8l
	cpu_architecture='arm'
elif [ .$cpu_name = .'i386' ]; then
	cpu_architecture='x86'
elif [ .$cpu_name = .'i686' ]; then
	cpu_architecture='x86'
elif [ .$cpu_name = .'x86_64' ]; then
	cpu_architecture='x86'
else
	error "You are using an unsupported cpu '$cpu_name'"
    exit 3
fi

if [ ."$cpu_architecture" = ."x86" ]; then
	wget -O - https://files.freeswitch.org/repo/deb/debian-release/fsstretch-archive-keyring.asc | apt-key add -
	echo "deb http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" > /etc/apt/sources.list.d/freeswitch.list
	echo "deb-src http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" >> /etc/apt/sources.list.d/freeswitch.list
fi
if [ ."$cpu_architecture" = ."arm" ]; then
	wget -O - https://files.freeswitch.org/repo/deb/rpi/debian-release/freeswitch_archive_g0.pub | apt-key add -
	echo "deb http://files.freeswitch.org/repo/deb/rpi/debian-release/ `lsb_release -sc` main" > /etc/apt/sources.list.d/freeswitch.list
	echo "deb-src http://files.freeswitch.org/repo/deb/rpi/debian-release/ `lsb_release -sc` main" >> /etc/apt/sources.list.d/freeswitch.list
fi

# Update cache
apt update