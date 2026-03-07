# REST API Crash Course with Node.js (OpenWeather One Call API 3.0)

This tutorial provides a **quick crash course on REST APIs** and shows how to build a **Node.js application that retrieves weather data using the OpenWeather One Call API 3.0**.

You will learn:

* What a REST API is
* Core REST concepts
* How to register and obtain an API key
* How to request weather data using coordinates
* How to build a Node.js REST client

---

# 1. What is a REST API?

A **REST API (Representational State Transfer API)** allows applications to communicate with each other over HTTP.

Typical workflow:

```
Client (browser / application)
        ↓ HTTP request
REST API server
        ↓ JSON response
Client receives structured data
```

Example request:

```
GET https://api.example.com/weather
```

Example response:

```json
{
  "temperature": 6,
  "condition": "Cloudy"
}
```

REST APIs typically return **JSON data** which is easy for programs to parse.

---

# 2. Core REST Concepts

## Resources

In REST, everything is treated as a **resource**.

Examples:

```
/weather
/users
/products
/orders
```

---

## HTTP Methods

| Method | Purpose       |
| ------ | ------------- |
| GET    | Retrieve data |
| POST   | Create data   |
| PUT    | Update data   |
| DELETE | Remove data   |

Example request:

```
GET /weather
```

---

## HTTP Status Codes

| Code | Meaning      |
| ---- | ------------ |
| 200  | Success      |
| 201  | Created      |
| 400  | Bad request  |
| 404  | Not found    |
| 500  | Server error |

---

# 3. Register for the Weather API

This tutorial uses the **OpenWeather API**.

## Step 1 — Create an Account

Register here:

```
https://home.openweathermap.org/users/sign_up
```

Fill in:

* Email
* Username
* Password

Then verify your email.

---

## Step 2 — Obtain an API Key

After logging in, go to:

```
https://home.openweathermap.org/api_keys
```

You will receive an API key similar to:

```
2f3c8xxxxxxxxxxxxxxxxxxxx
```

API keys may take **a few minutes to activate**.

---

# 4. OpenWeather One Call API 3.0

The **One Call API 3.0** provides:

* Current weather
* Hourly forecast
* Daily forecast
* Weather alerts

Unlike older APIs, it **requires geographic coordinates**.

Example request:

```
https://api.openweathermap.org/data/3.0/onecall?lat=43.6577&lon=-79.3818&units=metric&appid=API_KEY
```

Parameters:

| Parameter | Description        |
| --------- | ------------------ |
| lat       | Latitude           |
| lon       | Longitude          |
| appid     | Your API key       |
| units     | metric or imperial |

---

# 5. Example Coordinates

For this tutorial we use **Toronto** coordinates:

```
Latitude  = 43.6577
Longitude = -79.3818
```

---

# 6. Creating the Node.js Project

Create a new project:

```bash
mkdir weather-app
cd weather-app
npm init -y
```

Install dependencies:

```bash
npm install express axios
```

---

# 7. Project Structure

```
weather-app
│
├── app.js
└── package.json
```

---

# 8. Node.js Weather Application

Create `app.js`:

```javascript
const express = require("express");
const axios = require("axios");

const app = express();
const PORT = 3000;

const API_KEY = "YOUR_API_KEY";

// Toronto coordinates
const LAT = 43.6577;
const LON = -79.3818;

app.get("/weather", async (req, res) => {

  try {

    const url = `https://api.openweathermap.org/data/3.0/onecall?lat=${LAT}&lon=${LON}&units=metric&appid=${API_KEY}`;

    const response = await axios.get(url);

    const weather = response.data.current;

    res.json({
      temperature: weather.temp,
      humidity: weather.humidity,
      wind_speed: weather.wind_speed,
      description: weather.weather[0].description
    });

  } catch (error) {

    res.status(500).json({
      error: "Failed to fetch weather data"
    });

  }

});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```

---

# 9. Run the Server

Start the application:

```bash
node app.js
```

Expected output:

```
Server running on port 3000
```

---

# 10. Test the API

Open a browser or run:

```
http://localhost:3000/weather
```

Example response:

```json
{
  "temperature": 6.4,
  "humidity": 72,
  "wind_speed": 3.2,
  "description": "broken clouds"
}
```

---

# 11. Internal Workflow

```
Client (browser)
       ↓
GET /weather
       ↓
Node.js Express server
       ↓
Calls OpenWeather One Call API
       ↓
Receives JSON response
       ↓
Returns simplified JSON to the client
```

---

# 12. Recommended Production Improvements

Real applications normally include additional components.

### Environment Variables

Avoid storing API keys in code.

```
npm install dotenv
```

---

### Caching

Weather APIs are often rate‑limited. Use caching.

```
Redis
```

---

### Rate Limiting

Protect your API server.

```
express-rate-limit
```

---

### Input Validation

```
Joi
Zod
```

---

# 13. Typical REST Project Structure

```
project
│
├── controllers
│   weatherController.js
│
├── routes
│   weatherRoutes.js
│
├── services
│   weatherService.js
│
└── app.js
```

---

# 14. REST API Summary

REST APIs follow a simple architecture:

```
Client → HTTP Request → Server
Server → JSON Response → Client
```

Common backend frameworks:

```
Node.js + Express
Python + FastAPI / Flask
Java + Spring Boot
```

---

# License

MIT
