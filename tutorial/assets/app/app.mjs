import express from "express";

const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send(`Hello from: ${process.env.HOSTNAME}\n`);
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}\n`);
});