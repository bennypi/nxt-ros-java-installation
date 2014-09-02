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
sudo service udev restart
#switch to user
sudo -u $username bash << EOF
mkdir /home/$username/fuerte_workspace
echo "-------------------------------------------"
echo "-----------ROS initialisieren--------------"
rosws init /home/$username/fuerte_workspace /opt/ros/fuerte
echo "source /home/$username/fuerte_workspace/setup.bash" >> /home/$username/.bashrc
source /home/$username/.bashrc
echo "-------------------------------------------"
echo "-----------Gleich mit [y] bestätigen!------"
sleep 3
cd /home/$username/fuerte_workspace
rosws set rosnxt --hg http://stack-nxt.foote-ros-pkg.googlecode.com/hg/
rosws update
rosmake nxt_ros 
rosmake nxt_python
echo "-------------------------------------------"
echo "----------Gleich mit [y] bestätigen!-------"
sleep 3
rosws set --git --version=groovy rosjava_core 'git://github.com/rosjava/rosjava_core.git'
rosws update
echo "-------------------------------------------"
echo "---------Gleich mit [y] bestätigen!--------"
rosws set nxt-ros-java --git 'https://github.com/bennypi/nxt-ros-java.git'
echo "-------------------------------------------"
rosws update
cd rosjava_core
./gradlew install
./gradlew docs
./gradlew test
cd ../nxt-ros-java/nxt_ros_java
../../rosjava_core/gradlew clean
../../rosjava_core/gradlew build
../../rosjava_core/gradlew eclipse
./buildJar.sh
cp nxt_java_handler.jar ../example
cd ../example
./init.sh
echo "-------------------------------------------"
echo "----------Installation abgeschlossen-------"
echo "----------Computer neu starten-------------"
EOF

