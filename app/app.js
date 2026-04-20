const express = require('express');
const { Client } = require('pg');

const app = express();

const client = new Client({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: 5432,
  ssl: {
    rejectUnauthorized: false
  }
});

client.connect()
  .then(() => console.log("Connected to DB"))
  .catch(err => console.error("DB error:", err));

app.get('/', async (req, res) => {
  try {
    const result = await client.query('SELECT NOW()');
    res.send(`PR CI/CD SUCCESS 🚀🔥 | DB Time: ${result.rows[0].now}`);
  } catch (err) {
    res.send("DB error");
  }
});

app.listen(3000, () => {
  console.log('App running on port 3000');
});