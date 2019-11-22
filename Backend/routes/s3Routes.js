const passport = require('passport');
const keys = require('../config/keys');

module.exports = (app, AWS) => {
  const s3 = new AWS.S3({ apiVersion: '2006-03-01' });

  app.post(
    '/upload/face',
    (req, res, next) => {
      passport.authenticate('jwt', { session: false }, async (err, user) => {
        // check for token
        if (!Object.prototype.hasOwnProperty.call(req.headers, 'authorization')) {
          return res.status(200).json({ error: 'missing authorization token on header' });
        }

        if (!Object.prototype.hasOwnProperty.call(req.body, 'faceName')) {
          return res.status(400).json({ error: 'incomplete request (missing faceName field)' });
        }

        if (err || !user) {
          if (!err) {
            return res.status(200).json({ error: 'invalid token' });
          }
          return res.status(200).json({ error: err.message });
        }

        const bucketParams = {
          Bucket: keys.bucketName,
          Key: `${user._id}/${req.body.faceName}`,
          Expires: 60 * 60
        };

        const url = s3.getSignedUrl('putObject', bucketParams);

        return res.status(200).json({ url });
      })(req, res, next);
    },
  );

  app.get(
    '/upload/search',
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
          Key: `search/${user._id}`,
          Expires: 60 * 60,
        };

        const url = s3.getSignedUrl('getObject', bucketParams);

        return res.status(200).json({ url });
      })(req, res, next);
    },
  );
};
