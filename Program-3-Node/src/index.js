const express = require('express');
const app = express();
const PORT = 5000;

app.get('/', (req, res) => {
  res.send('Hello from Dockerized Node.js App (Program 3)!');
});

app.listen(PORT, () => {
  console.log(`Node app running on port ${PORT}`);
});
