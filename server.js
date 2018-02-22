var express = require("express");

const app = express();
const port = 8080;

app.use(express.static(__dirname));

app.get('/', (req, res) => {
  res.sendFile('index.html');
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
