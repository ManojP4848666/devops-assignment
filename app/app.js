const express = require('express');
const { Client } = require('pg');

const app = express();

const client = new Client({
  host: 'manojdb.chssc8kwme9n.ap-south-1.rds.amazonaws.com',
  user: 'postgres',
  password: 'postgres123',
  database: 'postgres',
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
    res.send(`DB Time: ${result.rows[0].now}`);
  } catch (err) {
    res.send("DB error");
  }
});

app.listen(3000, () => {
  console.log('App running on port 3000');
});