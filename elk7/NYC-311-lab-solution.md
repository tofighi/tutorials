# NYC 311 Data Visualization Tutorial (ELK 7.17.29)

This tutorial walks you through **end-to-end ingestion and visualization** of the NYC 311 dataset using Logstash, Elasticsearch, and Kibana.

---

# 📦 System Notes

* **Dataset size:** ~1 GB (`311.csv`)
* **Expected records:** 1M – 2M
* **Recommended disk:** ≥ 30GB (preferably more)
* **Ingestion time:** ~1 hour

⚠️ If you face storage issues:

* Delete previous clusters
* Recreate with larger disk

---

# ⚙️ Step 1: Create Elasticsearch Index (CRITICAL)

Before running Logstash, create the index with proper mapping:

```bash
curl -X PUT "localhost:9200/nyc311calls" -H 'Content-Type: application/json' -d '
{
  "mappings": {
    "properties": {
      "location": {
        "type": "geo_point"
      }
    }
  }
}'
```

🔥 **CRITICAL:** Only the `location` field must be explicitly mapped as `geo_point`. Other fields (e.g., `Descriptor`, `City`) can rely on Elasticsearch dynamic mapping.

If you skip this step, map visualization will NOT work.

---

# ⚙️ Step 2: Logstash Configuration

Create file: `311_logstash_updated.conf`

```conf
input {
  file {
    path => "/var/tmp/311.csv"
    start_position => "beginning"
    sincedb_path => "/dev/null"
  }
}

filter {
  csv {
    separator => ","
    skip_header => true
    columns => [
      "Unique Key","Created Date","Closed Date","Agency","Agency Name",
      "Complaint Type","Descriptor","Location Type","Incident Zip",
      "Incident Address","Street Name","Cross Street 1","Cross Street 2",
      "Intersection Street 1","Intersection Street 2","Address Type",
      "City","Landmark","Facility Type","Status","Due Date",
      "Resolution Action Updated Date","Community Board","Borough",
      "X Coordinate (State Plane)","Y Coordinate (State Plane)",
      "Park Facility Name","Park Borough","School Name","School Number",
      "School Region","School Code","School Phone Number","School Address",
      "School City","School State","School Zip","School Not Found",
      "School or Citywide Complaint","Vehicle Type","Taxi Company Borough",
      "Taxi Pick Up Location","Bridge Highway Name","Bridge Highway Direction",
      "Road Ramp","Bridge Highway Segment","Garage Lot Name","Ferry Direction",
      "Ferry Terminal Name","Latitude","Longitude","Location"
    ]
  }

  date {
    match => ["Created Date", "MM/dd/yyyy HH:mm:ss aa"]
    target => "@timestamp"
  }

  mutate {
    uppercase => ["City","Descriptor"]
    convert => {
      "Latitude" => "float"
      "Longitude" => "float"
    }
    remove_field => ["Location"]
  }

  mutate {
    add_field => {
      "[location][lat]" => "%{Latitude}"
      "[location][lon]" => "%{Longitude}"
    }
  }

  mutate {
    convert => {
      "[location][lat]" => "float"
      "[location][lon]" => "float"
    }
  }
}

output {
  elasticsearch {
    hosts => ["localhost:9200"]
    index => "nyc311calls"
  }
}
```

or download from here:

```bash
wget  https://raw.githubusercontent.com/tofighi/tutorials/refs/heads/master/elk7/configs/311_logstash_updated.conf -O 311_logstash_updated.conf
```
---

# ▶️ Step 3: Run Logstash

```bash
logstash -f 311_logstash_updated.conf
```

---

# 📊 Step 4: Create Index Pattern in Kibana

1. Go to **Stack Management → Index Patterns**
2. Create index pattern: `nyc311calls`
3. Select `@timestamp`

---

# 📈 Visualization Tasks

---

## 1️⃣ Table: Top 10 Cities + Top Descriptors

1. Go to **Visualize → Create → Data Table**
2. Index: `nyc311calls`

### Configure:

* **Buckets → Split rows**

  * Aggregation: Terms
  * Field: `City`
  * Size: 10

* Add sub-bucket:

  * Aggregation: Terms
  * Field: `Descriptor`
  * Size: 10

✔️ Result: Top cities with top descriptors

---

## 2️⃣ Pie Chart: Top 5 Cities + Descriptors

1. Create → Pie Chart

### Configure:

* **Split slices** → Terms → `City` (Size: 5)
* Add sub-bucket:

  * Terms → `Descriptor` (Size: 5)

---

## 3️⃣ Tag Cloud: Top 20 Descriptors

1. Create → Tag Cloud

### Configure:

* Field: `Descriptor`
* Size: 20

---

# 🗺️ Map Visualization (Challenge Solution)

## Step 1: Go to Maps

* Open **Maps → Create map**

## Step 2: Add Layer

* Choose **Documents**
* Index: `nyc311calls`
* Geospatial field: `location`

## Step 3: Style

* Enable clustering
* Color by `Complaint Type` or `Descriptor`

---

# 🧪 Verification

Check mapping:

```bash
curl localhost:9200/nyc311calls/_mapping?pretty
```

Expected:

```json
"location": {
  "type": "geo_point"
}
```

---

# 📊 Step 5: Build Dashboard

1. Go to **Dashboard → Create new**

2. Add:

   * Data Table
   * Pie Chart
   * Tag Cloud
   * Map

3. Arrange layout

4. Add filter control:

   * Field: `Descriptor`

---

# ⚠️ Common Issues

* Map not showing → geo_point missing
* No data → Logstash not finished
* Wrong filters → uppercase mismatch

---

# 🎯 Final Outcome

You will have:

* City-level insights
* Descriptor distribution
* Interactive filtering
* Geographic visualization of NYC complaints

---

# 🔥 Challenge Summary

✔ Convert lat/lon → geo_point
✔ Fix Logstash config
✔ Create mapping BEFORE ingestion
✔ Visualize in Kibana Maps


