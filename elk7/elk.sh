#!/bin/sh
sudo apt-get -qq install -y apt-transport-https wget unzip 2> /dev/null
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get -qq update
printf "\n==================================================================\n"
printf "Downloading and Installing elasticsearch, kibana, and logstash\n"
printf "\n==================================================================\n"
sudo apt-get -qq install -y  elasticsearch kibana logstash 2> /dev/null
wget -q https://raw.githubusercontent.com/tofighi/tutorials/master/elk7/configs/elasticsearch.yml
wget -q https://raw.githubusercontent.com/tofighi/tutorials/master/elk7/configs/kibana.yml
sudo mv elasticsearch.yml /etc/elasticsearch/
sudo mv kibana.yml /etc/kibana/
printf "\n==================================================================\n"
printf "Installation is completed!...Starting the services...\n"
printf "\n==================================================================\n"
sudo update-rc.d elasticsearch defaults 95 10
sudo update-rc.d kibana defaults 95 10
sudo -i service elasticsearch start
sudo -i service kibana start
echo 'export PATH="$PATH":/usr/share/logstash/bin/' >> ~/.bashrc
. ~/.bashrc
printf "\n==================================================================\n"
printf "elasticsearch port is 9200 and kibana port is 5601\n"
printf "Enjoy!\n"
printf "\n==================================================================\n"
rm -- "$0"

