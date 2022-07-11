#!/bin/bash
  sudo apt-get -y update
  # Install OpenJDK 8
  sudo apt-get -y install openjdk-11-jre-headless
  # Install Jenkins
  # (you can upadte the specific version from the link https://www.jenkins.io/doc/book/installing/linux/)
  curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
  echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
  sudo apt-get -y update
  sudo apt-get  -y install jenkins
  sudo systemctl start jenkins
  sudo systemctl status jenkins