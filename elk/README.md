# ELK installation on Dataproc on GCP

## Basic ELK stack installation
* Create Dataproc clusters with at least **150 GB** space with **16GB ram**
* Run below commands in your SSH terminal of your Master node in order:
  * **wget https://artifacts.elastic.co/downloads/logstash/logstash-6.7.1.tar.gz**
  * **wget http://sinamedialab.com/repository/documents/datasets/elk/elasticsearch-6.7.1.tar.gz**
  * **wget http://sinamedialab.com/repository/documents/datasets/elk/kibana-6.7.1-linux-x86_64.tar.gz**
  * **tar xf logstash-6.7.1.tar.gz**
  * **tar xf elasticsearch-6.7.1.tar.gz**
  * **tar xf kibana-6.7.1-linux-x86_64.tar.gz**
  * **mv logstash-6.7.1 logstash**
  * **mv elasticsearch-6.7.1 elasticsearch**
  * **mv kibana-6.7.1-linux-x86_64 kibana**

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
  * **wget http://sinamedialab.com/repository/documents/datasets/kaggle/cars.csv -O cars.csv**
  
  * Move the csv file to /var/tmp directory:
  * **mv cars.csv /var/tmp** 
  * **wget http://sinamedialab.com/repository/documents/datasets/elk/cars_logstash.conf -O cars_logstash.conf**

* Open new ssh window and run the following command in your home directory:
  * **logstash/bin/logstash -f  cars_logstash.conf**

## Running Kibana
* Open new ssh window and run the following:
  * **kibana/bin/kibana**

