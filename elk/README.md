# ELK installation

1) Create Dataproc clusters with at least 100 GB space


2) Run below commands in your SSH terminal of your Master node in order:

**wget https://artifacts.elastic.co/downloads/logstash/logstash-6.7.1.tar.gz

**wget http://sinamedialab.com/repository/documents/datasets/elk/elasticsearch-6.7.1.tar.gz

**wget http://sinamedialab.com/repository/documents/datasets/elk/kibana-6.7.1-linux-x86_64.tar.gz

**tar xf logstash-6.7.1.tar.gz

**tar xf elasticsearch-6.7.1.tar.gz

**tar xf kibana-6.7.1-linux-x86_64.tar.gz

**mv logstash-6.7.1 logstash

**mv elasticsearch-6.7.1 elasticsearch

**mv kibana-6.7.1-linux-x86_64 kibana



3) Open a new ssh window to run Elasticsearch and leave it running
Run the following commands:

(Each time you restart the server you should run the following commands to set enough memory and then run elasticsearch)

**sudo sysctl -w vm.max_map_count=262144**

**elasticsearch/bin/elasticsearch**

 

4) Test if Elasticsearch works by running the following command in ssh:

curl http://localhost:9200/

5) Download car dataset and **cars_logstash.conf** directly to the VM by running this command in a new SSH window

wget http://sinamedialab.com/repository/documents/datasets/kaggle/cars.csv -O cars.csv
wget http://sinamedialab.com/repository/documents/datasets/elk/cars_logstash.conf -O cars_logstash.conf

6) Open new ssh window and run the following command in your home directory:

logstash/bin/logstash -f  cars_logstash.conf


7) Open new ssh window and run the following:

kibana/bin/kibana

