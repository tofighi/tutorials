#!/bin/bash

# --- CONFIGURATION ---
ELASTIC_PASSWORD="elastic"
SERVER_IP=$(hostname -I | awk '{print $1}')

echo "--- 1. Installing Prerequisites & Repository ---"
apt-get update && apt-get install -y apt-transport-https wget gpg curl
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
# Corrected to the 8.x stable branch
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co stable main" | tee /etc/apt/sources.list.d/elastic-8.x.list

echo "--- 2. Installing Elasticsearch, Kibana, Logstash ---"
apt-get update && apt-get install -y elasticsearch kibana logstash

echo "--- 3. Enabling Services & Fixing Permissions ---"
systemctl daemon-reload
systemctl enable elasticsearch.service
systemctl enable kibana.service
systemctl enable logstash.service

# Fix Logstash Permissions to avoid "Path not writable" errors
chown -R logstash:logstash /usr/share/logstash/data
chown -R logstash:logstash /var/lib/logstash
chown -R logstash:logstash /var/log/logstash

# Ensure Logstash can read files in /var/tmp (common for CSV imports)
chmod 755 /var/tmp

echo "--- 4. Configuring & Starting Services ---"
# Allow remote access for Kibana
sed -i 's/#server.host: "localhost"/server.host: "0.0.0.0"/' /etc/kibana/kibana.yml

# Start Elasticsearch first
systemctl start elasticsearch
echo "Waiting 25 seconds for Elasticsearch to initialize..."
sleep 25

echo "--- 5. Setting 'elastic' User Password ---"
# Non-interactive password reset using a pipe
printf "${ELASTIC_PASSWORD}\n${ELASTIC_PASSWORD}" | /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic -i -b

# Start Kibana and Logstash
systemctl start kibana
systemctl start logstash

echo "--- FINAL SETUP SUMMARY ---"
echo "----------------------------------------------------------------"
echo "Elasticsearch: https://${SERVER_IP}:9200 (User: elastic / Pass: ${ELASTIC_PASSWORD})"
echo "Kibana: http://${SERVER_IP}:5601"
echo ""
echo "ENROLLMENT TOKEN (Paste into Kibana browser setup):"
/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana
echo ""
echo "VERIFICATION CODE (If prompted by Kibana):"
/usr/share/kibana/bin/kibana-verification-code
echo "----------------------------------------------------------------"
