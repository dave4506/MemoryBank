const http = require('http');
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const routes = require('./routes');

const app = express();

app.use(bodyParser.json({ type: '*/*' }));
app.use(cors());

routes(app);

// Start the application after the database connection is ready
const PORT = process.env.PORT || 80;

const server = http.createServer(app);

server.listen(PORT, () => {
  console.log(`Listening on port ${PORT}`);
});
