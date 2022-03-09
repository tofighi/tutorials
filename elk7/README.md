# Installing ELK 7 on Google Clould Platform (GCP)

In SSH Terminal of your Master node of Dataproc Cluster (or on a new virtual machine with 150GB storage and 16GB RAM, and 4 CPUs) run the following command to download installation script:

`curl -O https://raw.githubusercontent.com/tofighi/tutorials/master/elk7/elk.sh`

Then, give execution permission to `elk.sh`: (run in SSH Terminal)

`chmod +x ./elk.sh`

Finally, install the Elastic Stack using the following command:

`./elk.sh`
