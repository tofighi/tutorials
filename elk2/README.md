# ELK installation on Dataproc on GCP

## Open access to your GCP from your network
* Make sure your GCP instances are accessible from your network using firewall rules. There is an **easy but not safe for production** procedure which you can watch [here](https://www.youtube.com/watch?v=2HdYYoMwZWI). For research and development, you can use the proposed configuration.

## Basic ELK stack installation
* Create Dataproc clusters with at least **150 GB** space with **16GB ram**
* Run below commands in your SSH terminal of your Master node in order:
  * **wget https://artifacts.elastic.co/downloads/logstash/logstash-6.7.1.tar.gz**
  * **wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.7.1.tar.gz**
  * **wget https://artifacts.elastic.co/downloads/kibana/kibana-6.7.1-linux-x86_64.tar.gz**
  * **wget https://raw.githubusercontent.com/tofighi/tutorials/master/elk2/configs/elasticsearch.yml**
  * **wget https://raw.githubusercontent.com/tofighi/tutorials/master/elk2/configs/kibana.yml**
  * **tar xf logstash-6.7.1.tar.gz**
  * **tar xf elasticsearch-6.7.1.tar.gz**
  * **tar xf kibana-6.7.1-linux-x86_64.tar.gz**
  * **mv logstash-6.7.1 logstash**
  * **mv elasticsearch-6.7.1 elasticsearch**
  * **mv kibana-6.7.1-linux-x86_64 kibana**
  * **mv elasticsearch.yml elasticsearch/config/elasticsearch.yml**
  * **mv kibana.yml kibana/config/kibana.yml**

## Running Elasticsearch
* Open a new ssh window to run Elasticsearch and leave it running
Run the following commands:

  * **sudo sysctl -w vm.max_map_count=262144**
  * **elasticsearch/bin/elasticsearch**

* Test if Elasticsearch works by running the following command in ssh:
  * **curl http://localhost:9200/**

If you can see some reports about your elasticsearch, it means your elasticsearch running correctly.

## Running Logstash
* Download car dataset and **cars_logstash.conf** directly to the VM by running this command in a new SSH window
  * **wget https://raw.githubusercontent.com/tofighi/tutorials/master/elk2/data/cars.zip -O cars.zip**
  * **unzip cars.zip && rm cars.zip**
    * Move the csv file to `/var/tmp` directory:
    * **mv cars.csv /var/tmp** 
  * **wget https://raw.githubusercontent.com/tofighi/tutorials/master/elk2/logstash_configs/cars_logstash.conf -O cars_logstash.conf**

* Open new ssh window and run the following command in your home directory:
  * **logstash/bin/logstash -f  cars_logstash.conf**

## Running Kibana
* Open new ssh window and run the following (leave it running in it is own window):
  * **kibana/bin/kibana**
* Find out the **External IP** of your Master Node, and for example, if it is 45.33.22.55, you can now open Kibana in the following URL http://45.33.22.55:5601 (make sure you replace the 45.33.22.55 with your own server's IP)
