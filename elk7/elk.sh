#!/bin/sh
sudo apt install -y apt-transport-https wget unzip
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update
sudo apt-get install elasticsearch kibana logstash
wget -q https://raw.githubusercontent.com/tofighi/tutorials/master/elk7/configs/elasticsearch.yml
wget -q https://raw.githubusercontent.com/tofighi/tutorials/master/elk7/configs/kibana.yml
sudo mv elasticsearch.yml /etc/elasticsearch/
sudo mv kibana.yml /etc/kibana/
sudo update-rc.d elasticsearch defaults 95 10
sudo update-rc.d kibana defaults 95 10
sudo -i service elasticsearch start
sudo -i service kibana start
echo 'export PATH="$PATH":/usr/share/logstash/bin/' >> ~/.bashrc
chmod a+x ~/.bashrc
PS1='$ '
source ~/.bashrc
rm -- "$0"

