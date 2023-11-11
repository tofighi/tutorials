# Installing ELK 7 on Google Clould Platform (GCP)

In SSH Terminal of your Master node of Dataproc Cluster (or on a new virtual machine with 150GB storage and 16GB RAM, and 4 CPUs) run the following command to download installation script:

`curl -O https://raw.githubusercontent.com/tofighi/tutorials/master/elk7/elk.sh`

Then, give execution permission to `elk.sh`: (run in SSH Terminal)

`chmod +x ./elk.sh`

Finally, install the Elastic Stack using the following command:

`./elk.sh`

# Accessing Kibana and Elastic Search

* Kibana Port: 5601
* Elastic Search: 9200

Find out the External IP of your Master Node, and for example, if it is 45.33.22.55, you can now open Kibana in the following URL http://45.33.22.55:5601 
You should also be able to access elastic search using port 9200 (e.g. http://45.33.22.55:9200)

(make sure you replace the 45.33.22.55 with your own server's IP, and use http, not https). Also, make sure your firewall rules on cloud give access to these port

# Sample Dataset

wget https://raw.githubusercontent.com/tofighi/tutorials/master/elk2/data/cars.zip -O cars.zip

unzip cars.zip && rm cars.zip

mv cars.csv /var/tmp

wget https://raw.githubusercontent.com/tofighi/tutorials/master/elk2/logstash_configs/cars_logstash.conf -O cars_logstash.conf

Run Logstash with cars_logstash.conf

logstash -f cars_logstash.conf
