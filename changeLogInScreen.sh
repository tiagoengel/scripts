#!/bin/bash
xhost +SI:localuser:gdm
sudo su -lp gdm
dbus-launch gnome-appearance-properties
