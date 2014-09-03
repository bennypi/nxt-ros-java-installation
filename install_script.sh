#!/bin/bash
# Test ob Benutzer root ist
if [ "$(whoami)" != "root" ]; then
	echo "Bitte mit sudo ausführen"
	exit 1
fi
# Hinzufügen des ROS-Repos
# username zwischenspeichern
username=$SUDO_USER
echo "-------------------------------------------"
echo "------Repository und Key werden hinzugefügt"
sh -c '. /etc/lsb-release && echo "deb http://ros.informatik.uni-freiburg.de/packages/ros/ubuntu precise main" > /etc/apt/sources.list.d/ros-latest.list'
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
echo "-------------------------------------------"
echo "------Paketliste wird geladen--------------"
apt-get update
echo "-------------------------------------------"
echo "------Beginne mit der Installation.--------" 
echo "------Du musst die Paketliste gleich ------"
echo "------bestätigen---------------------------"
sleep 3
apt-get install ros-fuerte-desktop-full python-usb python-rosinstall python-rosdep python-usb
easy_install-2.7 pip
echo "-------------------------------------------"
echo "------Gruppen für die Lego-Benutzer--------"
echo "------werden angelegt----------------------"
sudo groupadd lego
sudo usermod -a -G lego $username
echo "SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"0694\", GROUP=\"lego\", MODE=\"0660\"" > /tmp/70-lego.rules && sudo mv /tmp/70-lego.rules /etc/udev/rules.d/70-lego.rules
echo "-------------------------------------------"
echo "----------Installation abgeschlossen-------"
echo "----------Computer neu starten-------------"
echo "----------config_script.sh ausführen-------"

