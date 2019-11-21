const AWS = require('aws-sdk');
const passport = require('passport');
const { ObjectID } = require('mongodb');
const authentication = require('../helpers/authentication');
const User = require('../models/User');
const keys = require('../config/keys');


AWS.config.credentials = new AWS.SharedIniFileCredentials({ profile: 'memoryBank-account' });

const s3 = new AWS.S3({ apiVersion: '2006-03-01' });

module.exports = (app, db) => {
  // ======= Local ============
  app.get(
    '/upload/signature',
    (req, res, next) => {
      passport.authenticate('jwt', { session: false }, async (err, user) => {
        // check for token
        if (!Object.prototype.hasOwnProperty.call(req.headers, 'authorization')) {
          return res.status(200).json({ error: 'missing authorization token on header' });
        }

        if (err || !user) {
          if (!err) {
            return res.status(200).json({ error: 'invalid token' });
          }
          return res.status(200).json({ error: err.message });
        }

        const bucketParams = {
          Bucket: keys.bucketName,
          Key: `${user._id}/image`,
          Expires: 60 * 60
        };

        const url = s3.getSignedUrl('getObject', bucketParams);

        return res.status(200).json({ url });
      })(req, res, next);
    },
  );
};
