##  NYC 311 Lab

### Dataset
NYC OpenData provides a dataset of **311 service requests** (since 2010), containing:
- ~21 million rows  
- 41 columns  

Original dataset:
https://nycopendata.socrata.com/Social-Services/311-Service-Requests-from-2010-to-Present/erm2-nwe9

---

### Setup (Dev Tools)

Download and prepare the data (a smaller set of the whole dataset):

```bash
wget https://huggingface.co/datasets/tofighi/BigDataCourse/resolve/main/311.zip -O 311.zip
unzip 311.zip && rm 311.zip
wget https://raw.githubusercontent.com/tofighi/tutorials/master/elk7/configs/311_logstash.conf
mv 311.csv /var/tmp
```

---

### Tasks (Elasticsearch / Logstash)

- Run **Logstash** using the provided configuration file.
- Display the **total number of documents** in the `nyc311calls` index.
- Display the **count of records where "heat" appears in the Descriptor** field.
- Write an **aggregation query** to find the **top 10 cities** with the highest number of calls.

---

### Visualization Tasks (Kibana)

- Create a **table**:
  - Top 10 cities with highest calls  
  - Along with the **top 10 descriptors per city**

- Create a **pie chart**:
  - Top 5 cities  
  - Along with the **top 5 descriptors per city**

- Create a **tag cloud**:
  - Top 20 call descriptors  

- Build a **dashboard** including all visualizations above.

---

### System Notes

- Expected indexed documents:  
  **Between 1,000,000 and 2,000,000 records**

- Dataset size:  
  **~1 GB (311.csv)**

- Storage consideration:
  - 30GB disk on Master Node **may not be sufficient**
  - Remove previous clusters and recreate a new one
  - Assign **at least 30GB** to Master Node

- Ingestion time:
  - Logstash may take **~1 hour** to index all data

---

### 🔥 Challenge Task (Important)

The dataset already contains **latitude and longitude (lat/lon)** fields.

👉 Your challenge:
- Modify the **Logstash configuration file (`311_logstash.conf`)**
- Convert the latitude and longitude fields into a **geo_point**
- Enable **map-based visualization in Kibana (Maps)**

💡 Hint:
- You will need to:
  - Update the **filter section** in Logstash
  - Create or modify a field like `location`
  - Ensure correct mapping to `geo_point` in Elasticsearch

🎯 Goal:
- Visualize the NYC 311 requests on a **map using geographic coordinates**

---
