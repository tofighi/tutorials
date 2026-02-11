#!/bin/sh

# Install basic deps
sudo apt-get -qq update
sudo apt-get -qq install -y wget unzip 2> /dev/null

ES_DEB="elasticsearch-7.17.29-amd64.deb"
KB_DEB="kibana-7.17.29-amd64.deb"
LS_DEB="logstash-7.17.29-amd64.deb"

cd /tmp

printf "\n==================================================================\n"
printf "Downloading elasticsearch, kibana, and logstash .deb packages\n"
printf "==================================================================\n"

# Download deb packages directly
wget -q https://artifacts.elastic.co/downloads/elasticsearch/$ES_DEB
wget -q https://artifacts.elastic.co/downloads/kibana/$KB_DEB
wget -q https://artifacts.elastic.co/downloads/logstash/$LS_DEB

printf "\n==================================================================\n"
printf "Installing elasticsearch, kibana, and logstash\n"
printf "==================================================================\n"

# Install them via dpkg and fix dependencies if needed
sudo dpkg -i $ES_DEB $KB_DEB $LS_DEB 2> /dev/null || sudo apt-get -f install -y -qq

# Pull configs
wget -q https://raw.githubusercontent.com/tofighi/tutorials/master/elk7/configs/elasticsearch.yml
wget -q https://raw.githubusercontent.com/tofighi/tutorials/master/elk7/configs/kibana.yml

sudo mv elasticsearch.yml /etc/elasticsearch/
sudo mv kibana.yml /etc/kibana/

printf "\n==================================================================\n"
printf "Installation is completed!...Starting the services...\n"
printf "==================================================================\n"

# Enable and start services
sudo update-rc.d elasticsearch defaults 95 10
sudo update-rc.d kibana defaults 95 10

sudo -i service elasticsearch start
sudo -i service kibana start

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service
sudo /bin/systemctl enable elasticsearch.service
sudo /bin/systemctl enable logstash.service 2> /dev/null || true

# Logstash path / permissions / PATH
sudo chmod 777 /usr/share/logstash/data 2> /dev/null || true
echo 'export PATH="$PATH":/usr/share/logstash/bin/' >> ~/.bashrc

exec bash

printf "\n==================================================================\n"
printf "elasticsearch port is 9200 and kibana port is 5601\n"
printf "Enjoy!\n"
printf "==================================================================\n"

rm -- "$0"
