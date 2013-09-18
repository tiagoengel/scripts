#/bin/bash
if [ "$USER" != "root" ] ; then
   echo "Run as root!"
   exit 1
fi

ip link set vboxnet0 down
ip link set vboxnet0 up
ip addr add 193.169.1.5/24 dev vboxnet0


