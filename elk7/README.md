# Installing ELK 7 on Google Clould Platform (GCP)

In the SSH Terminal of your Master node of the Dataproc Cluster (or on a new virtual machine with 30GB storage and 16GB RAM, and 4 CPUs), run the following command to download the installation script:

`curl -O https://raw.githubusercontent.com/tofighi/tutorials/master/elk7/elk.sh`

Then, give execution permission to `elk.sh`: (run in SSH Terminal)

`chmod +x ./elk.sh`

Finally, install the Elastic Stack using the following command:

`./elk.sh`

[Watch the video tutorial for installation](https://www.youtube.com/watch?v=bY8w__KKElk)

# Accessing Kibana and Elastic Search

* Kibana Port: 5601
* Elastic Search: 9200

Find out the External IP of your Master Node, and for example, if it is 45.33.22.55, you can now open Kibana in the following URL: http://45.33.22.55:5601 
You should also be able to access Elastic Search using port 9200 (e.g., http://45.33.22.55:9200)

(Make sure you replace the 45.33.22.55 with your own server's IP, and use http, not https). Also, make sure your firewall rules on the cloud give access to these port. 

**Note 1:** If you have a problem loading the server, check your firewall rules. [Watch the video to see how you can open access to your server from any computer](https://www.youtube.com/watch?v=2HdYYoMwZWI)

**Note 2:** Remember to delete the cluster when you are done

# Sample Dataset

wget https://raw.githubusercontent.com/tofighi/tutorials/master/elk2/data/cars.zip -O cars.zip

unzip cars.zip && rm cars.zip

mv cars.csv /var/tmp

wget https://raw.githubusercontent.com/tofighi/tutorials/master/elk2/logstash_configs/cars_logstash.conf -O cars_logstash.conf

Run Logstash with cars_logstash.conf

logstash -f cars_logstash.conf
