# Installing ELK 7 on Google Cloud Platform (GCP)

## Overview

In this guide, you will install the **Elastic Stack (ELK 7)** on:

* A **Dataproc Master Node**, or
* A **GCP Virtual Machine** with:

  * 30 GB storage
  * 16 GB RAM
  * 4 CPUs

---

## Step 1 — Download Installation Script

### Command

```bash
curl -O https://raw.githubusercontent.com/tofighi/tutorials/master/elk7/elk.sh
```

### Explanation

* Downloads the ELK installation script (`elk.sh`) from GitHub to your current directory.

---

## Step 2 — Make Script Executable

### Command

```bash
chmod +x ./elk.sh
```

### Explanation

* Grants execution permission so the script can be run.

---

## Step 3 — Install ELK Stack

### Command

```bash
./elk.sh
```

### Explanation

* Executes the script to install:

  * Elasticsearch
  * Logstash
  * Kibana

---

## Video Tutorial

Watch a step-by-step walkthrough:
[https://www.youtube.com/watch?v=bY8w__KKElk](https://www.youtube.com/watch?v=bY8w__KKElk)

---

# Accessing Kibana and Elasticsearch

## Default Ports

| Service       | Port |
| ------------- | ---- |
| Kibana        | 5601 |
| Elasticsearch | 9200 |

---

## Step 1 — Find External IP

* Go to your GCP VM or Dataproc cluster
* Copy the **External IP address**

---

## Step 2 — Access Services

Replace `<YOUR_IP>` with your actual external IP:

### Kibana

```
http://<YOUR_IP>:5601
```

### Elasticsearch

```
http://<YOUR_IP>:9200
```

### Example

```
http://45.33.22.55:5601
```

---

## Important Notes

### Firewall Configuration

If the pages do not load:

* Ensure ports **5601** and **9200** are open in your GCP firewall rules.

Tutorial:
[https://www.youtube.com/watch?v=2HdYYoMwZWI](https://www.youtube.com/watch?v=2HdYYoMwZWI)

---

### Protocol Warning

* Use **HTTP**, not HTTPS

---

### Cost Reminder

* Delete your cluster or VM after use to avoid unnecessary charges

---

# Loading a Sample Dataset

## Step 1 — Download Dataset

### Command

```bash
wget https://raw.githubusercontent.com/tofighi/tutorials/master/elk2/data/cars.zip -O cars.zip
```

---

## Step 2 — Extract Files

### Command

```bash
unzip cars.zip && rm cars.zip
```

### Explanation

* Unzips the dataset and removes the zip file to save space.

---

## Step 3 — Move Dataset

### Command

```bash
mv cars.csv /var/tmp
```

---

## Step 4 — Download Logstash Configuration

### Command

```bash
wget https://raw.githubusercontent.com/tofighi/tutorials/master/elk2/logstash_configs/cars_logstash.conf -O cars_logstash.conf
```

---

## Step 5 — Run Logstash

### Command

```bash
logstash -f cars_logstash.conf
```

### Explanation

* Starts Logstash using the provided configuration file
* Imports the dataset into Elasticsearch

---

## Summary

You have now:

* Installed the ELK stack
* Accessed Kibana and Elasticsearch
* Loaded a sample dataset using Logstash
