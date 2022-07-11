#!/bin/bash
  sudo apt-get update -y 
  sudo su -
  apt-get update -y
  apt install -y openjdk-11-jre-headless
  apt install -y unzip
  apt install -y net-tools
  # Install sonarqune
  wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.4.0.54424.zip
  # (you can upadte the specific version from the link https://www.sonarqube.org/downloads/)
  mv sonarqube-9.4.0.54424.zip /opt/
  cd /opt/
  unzip sonarqube-9.4.0.54424.zip
  adduser sonaradmin 
  chown -R sonaradmin:sonaradmin sonarqube-9.4.0.54424
  cd sonarqube-9.4.0.54424/
  cd bin/
  cd linux-x86-64/
  su sonaradmin
  ./sonar.sh
  ./sonar.sh start
  ./sonar.sh status
   netstat -ntlp
    
 
