# ELK installation

1) Create Dataproc clusters with at least 100 GB space


2) Run below commands in your SSH terminal for Master Node in order:
wget https://artifacts.elastic.co/downloads/logstash/logstash-6.7.1.tar.gz
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.7.1.tar.gz
wget https://artifacts.elastic.co/downloads/kibana/kibana-6.7.1-linux-x86_64.tar.gz

tar xf logstash-6.7.1.tar.gz
tar xf elasticsearch-6.7.1.tar.gz
tar xf kibana-6.7.1-linux-x86_64.tar.gz

mv logstash-6.7.1 logstash
mv elasticsearch-6.7.1 elasticsearch
mv kibana-6.7.1-linux-x86_64 kibana

3) Change configs files for elasticsearch and kibana using vim (if you do not know how to use vim, please look at this post)

run the following command:

vim elasticsearch/config/elasticsearch.yml

after the config file is opened in the vim, press i on keyboard to start editing the file. Using arrow keys get to the line contains this:
#network.host: 192.168.0.1
You should change it to this:
network.host: 0.0.0.0

After completing your edit, press ESC button on keyboard. Then press : and then press x(lowercase). If you hit the Enter now, you will save the changes.
Anytime you want to get back to edit mode, hit ESC and i again. Anytime you want to save hit ESC then : then x (lowercase) and then Enter.
This enables access to Elasticsearch from any computer.

You should do similar thing for Kibana:
run the following command:

vim kibana/config/kibana.yml

On the second line, uncomment this:
#server.port: 5601
It should become:
server.port: 5601

and

#server.host: "localhost"


should become the following. Make sure you do not miss any spaces. It should be exactly the same:



server.host: "0.0.0.0"


4) Open a new SSH window to run Elasticsearch and leave it running
Run the following commands:

(Each time you restart the server you should run the following commands to set enough memory and then run elasticsearch)

sudo sysctl -w vm.max_map_count=262144
elasticsearch/bin/elasticsearch

 

5) Test if Elasticsearch works:

curl http://localhost:9200/

6) Download car dataset directly to the VM by running this command in a new SSH window
wget http://sinamedialab.com/repository/documents/datasets/kaggle/cars.csv -O cars.csv

7) Upload the cars_logstash.conf to your home directory. (download it from this module)

vim cars_logstash.conf

Use VIM () to change the path to your path (instead of my name, you should write your username instead of mine (ghassem8222) in the following line)

path => "/home/ghassem8222/cars.csv"

Then run the following command in your home directory 
logstash/bin/logstash -f  cars_logstash.conf


8) Open new SSH window and run the following:
kibana/bin/kibana


Note (dangerous command!):

If you want to remove all previous indexes in your EKK run the following:
curl -X DELETE 'http://localhost:9200/_all'