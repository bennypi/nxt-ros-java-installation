nxt-ros-java-installation
=========================
Dieses Repository enthält ein Bash-Script, mit dem Software installiert und konfiguriert wird, um den NXT-Roboter von Lego über die USB-Schnittstelle mit einem Java-Programm zu steuern.

Was wird benötigt
----
Zunächst wird ein Computer mit Linux benötigt. Es wird _dringend_ empfohlen, dafür Ubuntu 12.04 LTS zu benutzen. 
Außerdem werden ein JDK >=6, Python und git auf dem Computer gebraucht.

Was wird installiert
----
Wenn das install_script.sh ausgeführt wird, werden einige Programme installiert. Diese werden im folgenden aufgelistet.

1.  Zunächst wird ROS installiert. ROS steht für Robot Operating System und dient dazu, die verschiedenen Komponenten des Roboters und der Software zu verbinden. Wir benutzen dazu die Version ROS Fuerte. Diese wird nach dieser Anleitung installiert: [klick](http://wiki.ros.org/fuerte/Installation/Ubuntu)
2.  Anschließend wird eine neue Gruppe angelegt, die Lego heißt. Der aktuelle Benutzer wird dieser Gruppe hinzugefügt, und die Gruppe bekommt besondere Rechte, um mit dem NXT-Roboter über USB kommunizieren zu können.
3.  ROS wird initialisiert und konfiguriert. Dazu wird ein so genannter Workspace angelegt, siehe [rosbuild](http://wiki.ros.org/ROS/Tutorials/InstallingandConfiguringROSEnvironment). Dieser befindet sich im Ordner /home/$BENUTZERNAME/fuerte_workspace
4.  Es werden drei Pakete zu ROS hinzugefügt:
    - rosnxt: Dieses Paket nimmt die Steuerbefehle für den Roboter entgegen und verteilt die Sensorinformationen an die Software
    - rosjava_core: Dieses Paket sorgt dafür, dass Java-Programme mit ROS kommunizieren können
    - nxt-ros-java: Dieses Paket liefert die Bibliotheken, damit Sie eine API zur Verfügung haben, um den NXT zu programmieren
5. Anschließend werden die rosjava_core Pakete gebaut, um die Bibliotheken bereit zu stellen.

Wie wird es benutzt
----
Es wird ein Eclipse-Projekt angelegt. Dieses befindet sich in /home/$BENUTZERNAME/fuerte_workspace/nxt-ros-java/example und kann in Eclipse importiert werden. Im src-Ordner gibt es das "org.ros.nxt_ros_java"-package, in dem sich wiederum zwei Klassen befinden:
1.  Robot.java Diese Klasse biete alle Methoden, um den Roboter zu benutzen. Man kann die Mototen ansteuern und die Sensordaten auslesen. Ein Beispiel, wie man diese Methoden benutzt, sieht man in der zweiten Klasse:
2.  Robotexample.java In dieser Klasse sieht man ein Beispiel, wie man eine Klasse schreiben muss, um den Roboter zu steuern. In diesem Fall wurde die Methode driveUntilObstacle geschrieben, die ein Objekt vom Typ Robot übergeben bekommt. Der Roboter fährt so lange nach vorne, bis der Ultraschallsensor ein Objekt in weniger als 30cm Entfernung sieht. Dann bleibt der Roboter stehen.

Da die Roboter ganz verschieden zusammengebaut werden können, muss man dem System sagen, an welchem Port welcher Sensor angesteckt ist. Man kann jeden Sensor nur ein mal benutzen, und folgende Sensoren werden unterstützt: Licht-, Farb-, Berührungs- und Ultraschallsensor.
Die Konfiguration des Roboters wird in der robot.yaml-Datei in dem example-Ordner festgelegt.
