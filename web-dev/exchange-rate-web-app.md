# 💻 Project: Exchange Rate Web App with Real-Time P2P Chat

## 🎯 Objective

Design and implement a full-stack web application using **Express.js**, **MongoDB**, **Bootstrap**, and **Socket.IO**.

The system will:

* Authenticate users (register/login)
* Retrieve exchange rates using a single API
* Cache recent queries
* Display recent searches on the UI
* Enable real-time peer-to-peer (P2P) chat for better exchange deals

---

## 🧰 Required Technologies

* Backend: Node.js + Express.js
* Database: MongoDB
* Frontend: HTML, CSS, JavaScript
* UI Framework: Bootstrap
* Real-time: Socket.IO

---

## 🌐 API

Use ONLY:

* [https://currencylayer.com/pricing](https://currencylayer.com/pricing)

---

## 📋 Requirements

### 1. Authentication

* Users must register and log in
* Email is used as username
* Password rules:

  * Minimum 10 characters
  * Must include at least one number
* Store user credentials in MongoDB

---

### 2. Currency Conversion Feature

After login, users can:

* Select currencies using dropdowns:

  * FROM: USD, EUR, CAD
  * TO: USD, EUR, CAD (excluding same selection)

* Click **Convert** to:

  * Call the API
  * Display the conversion rate

---

### 3. Recent Queries (UI + Database)

* Every query must be stored in the database
* Store:

  * Base currency
  * Target currency
  * Rate
  * Timestamp

#### Optimization:

* If the same query was made within the last **1 hour**:

  * Use cached result
  * Do NOT call API again

#### UI Requirement:

* Display **latest queries under the dropdown form**
* Show:

  * Currency pair
  * Rate
  * Time of request

---

### 4. Real-Time P2P Chat (Socket.IO)

After login, users can access a chat system designed for:

> Negotiating better exchange rates with other users in the same city

#### Features:

* Real-time messaging
* Broadcast messages to all users
* Show username with each message
* Join/leave notifications

#### Purpose:

* Allow users to:

  * Offer better exchange rates
  * Find local exchange partners

---

## 🎨 UI Requirements (Bootstrap Mandatory)

### Dashboard Layout

#### Currency Section

* Bootstrap form with:

  * Dropdown (form-select)
  * Convert button
* Result display using:

  * Cards or alerts

#### Recent Queries Section

* Table or list-group under form
* Dynamically updated

#### Chat Section

* Message list (scrollable)
* Input group for messages
* Clean layout using Bootstrap grid

---

## 🗄️ Database Schema

### Users

```json
{
  "email": "user@example.com",
  "password": "hashed_password"
}
```

### Exchange Queries

```json
{
  "base": "USD",
  "target": "CAD",
  "rate": 1.35,
  "timestamp": "2026-03-21T10:00:00Z"
}
```

---

## ⚙️ Detailed Project Structure

```
project/
│── server.js                # Main Express server + Socket.IO setup
│── package.json
│
├── config/
│   └── db.js               # MongoDB connection setup
│
├── models/
│   ├── User.js             # User schema (email, password)
│   └── Exchange.js         # Exchange query schema
│
├── routes/
│   ├── auth.js             # Register/Login routes
│   ├── exchange.js         # Currency conversion + caching logic
│   └── queries.js          # Fetch recent queries
│
├── controllers/
│   ├── authController.js
│   ├── exchangeController.js
│   └── queryController.js
│
├── middleware/
│   └── authMiddleware.js   # (Optional) Protect routes
│
├── services/
│   └── currencyService.js  # Handles API calls to currencylayer
│
├── sockets/
│   └── chat.js             # Socket.IO chat logic
│
├── public/
│   ├── index.html          # Login/Register page
│   ├── dashboard.html      # Main UI (conversion + recent queries + chat)
│   ├── css/
│   │   └── styles.css
│   └── js/
│       ├── auth.js         # Login/Register logic
│       ├── exchange.js     # API calls + UI updates
│       ├── chat.js         # Socket.IO client
│       └── queries.js      # Fetch/display recent queries
│
└── views/ (optional if using templating engine)
    └── *.ejs
```

### Notes:

* `services/` separates external API logic (clean design)
* `controllers/` keeps route logic organized
* `sockets/` isolates real-time features
* `public/` contains all frontend assets (Bootstrap UI)
* `middleware/` can be extended for authentication/authorization

---
