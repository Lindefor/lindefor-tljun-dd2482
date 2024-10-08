import express from "express";

const app = express();
const port = 3000;

app.get('/', (req, res) => {
  const name = process.env.HOSTNAME ? process.env.HOSTNAME : 'Docker container';
  res.send(`Hello from: ${name}!\n`);
});

app.get('/db_pass', (req, res) => {
  if (!process.env.DB_PASSWORD) {
    res.status(500).send('Database password not set');
    return;
  }
  res.send(`Hello World! The database password is: ${process.env.DB_PASSWORD}\n`);
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}\n`);
});