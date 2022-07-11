
sudo apt-get update -y
sudo apt-get install -y adduser libfontconfig1
# Install Grafana
# (you can upadte the specific version from the link https://grafana.com/grafana/download) 
wget https://dl.grafana.com/oss/release/grafana_7.3.4_amd64.deb
sudo dpkg -i grafana_7.3.4_amd64.deb
sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl status grafana-server
sudo systemctl enable grafana-server.service

