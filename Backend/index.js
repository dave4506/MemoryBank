const http = require('http');
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const { MongoClient } = require('mongodb');
const AWS = require('aws-sdk');
const passport = require('passport');

const keys = require('./config/keys');
const routes = require('./routes');
const Strategies = require('./services/passport');

const app = express();
AWS.config.credentials = new AWS.Credentials(keys.AWS_accessKeyId, keys.AWS_secretAccessKey);

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

  // set up startegies with current db pool
  const strategies = new Strategies(db);

  // tell pasport to use this strategy
  passport.use(strategies.jwtLogin);
  passport.use(strategies.localLogin);

  routes(app, db, AWS);

  // Start the application after the database connection is ready
  const PORT = process.env.PORT || 80;

  // const server = https.createServer(httpsServerOptions, app);
  const server = http.createServer(app);

  server.listen(PORT, () => {
    console.log(`Listening on port ${PORT}`);
  });
});
