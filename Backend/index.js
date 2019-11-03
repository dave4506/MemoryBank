const http = require('http');
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const keys = require('./config/keys');
const { MongoClient } = require('mongodb');
const passport = require('passport');
const routes = require('./routes');
const app = express();

let db;

app.use(bodyParser.json({ type: '*/*' }));
app.use(cors());
app.use(passport.initialize());


// Initialize mongoDB connection once
MongoClient.connect(keys.mongoURL, {
  useNewUrlParser: true,
  w: 1,
  native_parser: false,
  ssl: keys.mongoSSL,
  poolSize: 1,
  connectTimeoutMS: 500,
},
(err, mongoClient) => {
  if (err) throw err;
  
  db = mongoClient.db('MemoryBank');

  // tell pasport to use this strategy
  // passport.use(strategies.jwtLogin);
  // passport.use(strategies.localLogin);

  routes(app, db);

  // Start the application after the database connection is ready
  const PORT = process.env.PORT || 80;

  // const server = https.createServer(httpsServerOptions, app);
  const server = http.createServer(app);

  server.listen(PORT, () => {
    console.log(`Listening on port ${PORT}`);
  });
});
