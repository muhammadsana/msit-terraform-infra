  #!/bin/bash
  sudo apt-get update
  sudo apt-get -y install openjdk-8-jre-headless
  # install nexus 
  # (you can update the specific version from the link https://help.sonatype.com/repomanager3/product-information/download)
  wget https://download.sonatype.com/nexus/oss/nexus-2.14.21-02-bundle.tar.gz
  tar -xvzf nexus-2.14.21-02-bundle.tar.gz
  cd  nexus-2.14.21-02
  cd bin
  ./nexus start
  ./nexus status
 
 
