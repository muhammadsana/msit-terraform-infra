#!/bin/bash
  sudo apt-get update -y 
  apt-get install unzip -y
  sudo apt install openjdk-11-jre-headless -y
  java -version
  cd opt/
  # Install Jfrog
  #  (you can upadte the specific version from the link https://jfrog.com/download-legacy/?product=pipelines&installer=linux)
  wget https://jfrog.bintray.com/artifactory/jfrog-artifactory-oss-6.9.5.zip
  ls -la
  unzip jfrog-artifactory-oss-6.9.5.zip
  cd  artifactory-oss-6.9.5
  ls -la
  cd bin/
  ./artifactory.sh start
  ./artifactory.sh status
  netstat -ntlp


