const http = require('http');
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const keys = require('./config/keys');

const routes = require('./routes');

const app = express();

app.use(bodyParser.json({ type: '*/*' }));
app.use(cors());

routes(app);

// Start the application after the database connection is ready
const PORT = process.env.PORT || 80;

const server = http.createServer(app);

const MongoClient = require('mongodb').MongoClient;
const uri = keys.mongoUri;
const client = new MongoClient(uri, { useNewUrlParser: true });

client.connect(err => {
    assert.equal(null, err);
    console.log("Connected successfully to server");
    const db = client.db(dbConfig.DBName);

    server.listen(PORT, () => {
      console.log(`Listening on port ${PORT}`);
    });
});
