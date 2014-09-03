#!/bin/bash
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
echo "----------eclipse starten------------------"

