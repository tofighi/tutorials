# REST API Crash Course with Node.js Weather Example

This short tutorial explains:

* What REST APIs are
* Core REST concepts
* How to call a weather API
* How to build a simple Node.js REST client

---

# 1. What is a REST API?

A REST API (Representational State Transfer API) allows applications to communicate over HTTP.

Example workflow:

```
Client (browser / app)
↓ HTTP request
REST API Server
↓ JSON response
Client receives data
```

Example request:

```
GET https://api.weather.com/weather?city=Toronto
```

Example response:

```json
{
  "city": "Toronto",
  "temperature": 6,
  "condition": "Cloudy"
}
```

---

# 2. REST Core Concepts

## Resources

In REST, everything is treated as a resource.

Examples:

```
/users
/weather
/products
/orders
```

---

## HTTP Methods

| Method | Purpose     | Example        |
| ------ | ----------- | -------------- |
| GET    | Read data   | Get weather    |
| POST   | Create data | Create user    |
| PUT    | Update data | Update profile |
| DELETE | Remove data | Delete order   |

Example request:

```
GET /weather/Toronto
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

# 3. REST Response Format

Most REST APIs use JSON.

Example:

```json
{
  "city": "Toronto",
  "temperature": 4,
  "humidity": 70
}
```

---

# 4. Weather API Example

This tutorial uses OpenWeather API.

Example request:

```
https://api.openweathermap.org/data/2.5/weather?q=Toronto&appid=API_KEY
```

## Register and Get an API Key

To use the weather API you must create a free account and obtain an API key.

### Step 1 — Create an Account

Open the registration page:

```
https://home.openweathermap.org/users/sign_up
```

Fill in:

* Email
* Username
* Password

Then confirm your email address.

### Step 2 — Generate an API Key

After logging in, go to the API keys page:

```
https://home.openweathermap.org/api_keys
```

You will see a default key such as:

```
2f3c8xxxxxxxxxxxxxxxxxxxx
```

You can also create additional keys if needed.

### Step 3 — Wait for Activation

New keys may take **5–10 minutes** to activate.

### Step 4 — Use the API Key in Requests

Example request:

```
https://api.openweathermap.org/data/2.5/weather?q=Toronto&appid=YOUR_API_KEY
```

Replace:

```
YOUR_API_KEY
```

with your actual

# 5. Node.js Weather Application

Technologies used:

* Node.js
* Express.js
* Axios

---

# Step 1 — Create the Project

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

# Step 2 — Project Structure

```
weather-app
│
├── app.js
└── package.json
```

---

# Step 3 — Node.js Application

Create `app.js`:

```javascript
const express = require("express");
const axios = require("axios");

const app = express();
const PORT = 3000;

const API_KEY = "YOUR_API_KEY";

app.get("/weather/:city", async (req, res) => {

  const city = req.params.city;

  try {

    const response = await axios.get(
      `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric`
    );

    const data = response.data;

    res.json({
      city: data.name,
      temperature: data.main.temp,
      humidity: data.main.humidity,
      condition: data.weather[0].description
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

# Step 4 — Run the Server

Start the application:

```bash
node app.js
```

Output:

```
Server running on port 3000
```

---

# Step 5 — Test the API

Open your browser or run:

```
http://localhost:3000/weather/Toronto
```

Example response:

```json
{
  "city": "Toronto",
  "temperature": 5,
  "humidity": 80,
  "condition": "light rain"
}
```

---

# 6. Internal Workflow

```
Browser
↓
GET /weather/Toronto
↓
Node.js Express server
↓
Calls OpenWeather API
↓
Receives JSON
↓
Returns simplified JSON to client
```

---

# 7. Production Improvements

Real applications usually include:

### Environment variables

```
npm install dotenv
```

### Caching

```
Redis
```

### Rate limiting

```
express-rate-limit
```

### Input validation

```
Joi
Zod
```

---

# 8. Typical REST Project Structure

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

# 9. Example REST API Design

```
GET /weather/Toronto
GET /weather?city=Toronto
POST /users
PUT /users/42
DELETE /users/42
```

---

# 10. REST API Summary

REST APIs follow a simple pattern:

```
Client → HTTP Request → Server
Server → JSON Response → Client
```

Using HTTP methods:

```
GET
POST
PUT
DELETE
```

Common implementations:

```
Node.js + Express
Python + Flask / FastAPI
Java + Spring Boot
```

---

# License

MIT
