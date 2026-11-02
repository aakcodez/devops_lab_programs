const express = require("express");
const app = express();
const PORT = 3000;

app.get("/", (req, res) => {
  res.send("Hello from Program 6 Docker Registry Pipeline!");
});

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
