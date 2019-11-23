const passport = require('passport');
const keys = require('../config/keys');

module.exports = (app, db, AWS) => {
  const rekognition = new AWS.Rekognition({ apiVersion: '2016-06-27', region: 'us-east-1' });
  const s3 = new AWS.S3({ apiVersion: '2006-03-01' });

  app.post(
    '/rekognize',
    (req, res, next) => {
      passport.authenticate('jwt', { session: false }, async (err, user) => {
        // check for token
        if (!Object.prototype.hasOwnProperty.call(req.headers, 'authorization')) {
          return res.status(401).json({ error: 'missing authorization token on header' });
        }

        if (!Object.prototype.hasOwnProperty.call(req.body, 'faceName')) {
          return res.status(400).json({ error: 'incomplete request (missing faceName field)' });
        }

        if (err || !user) {
          if (!err) {
            return res.status(401).json({ error: 'invalid token' });
          }
          return res.status(401).json({ error: err.message });
        }

        // get filename for all images for user
        const s3Params = {
          Bucket: keys.bucketName, /* required */
          Prefix: `${user._id}/${req.body.faceName}/`,
        };

        const rekognitionParams = {
          CollectionId: keys.collectionId,
          Image: {
            S3Object: {
              Bucket: keys.bucketName,
              Name: '',
            },
          },
          MaxFaces: 1,
        };

        s3.listObjects(s3Params, (error, files) => {
          if (error) {
            return res.status(500).json({ error: 'Could not retrieve s3 objects' });
          }

          for (let i = 0; i < files.Contents.length; i++) {
            rekognitionParams.Image.S3Object.Name = files.Contents[i].Key;

            rekognition.indexFaces(rekognitionParams, (erro, response) => {
              if (erro) {
                return res.status(500).json({ error: 'could not indexFace into aws Rekogtion' });
              }

              const obj = {
                FaceId: response.FaceRecords[0].Face.FaceId,
                Name: req.body.faceName,
              };

              db.collection('faces').insertOne(obj);
            });
          }

          return res.status(200).json({ message: 'Succesfully added face to aws Rekognition' });
        });
      })(req, res, next);
    },
  );

  app.get(
    '/search',
    (req, res, next) => {
      passport.authenticate('jwt', { session: false }, async (err, user) => {
        // check for token
        if (!Object.prototype.hasOwnProperty.call(req.headers, 'authorization')) {
          return res.status(401).json({ error: 'missing authorization token on header' });
        }

        if (err || !user) {
          if (!err) {
            return res.status(401).json({ error: 'invalid token' });
          }
          return res.status(401).json({ error: err.message });
        }

        const params = {
          CollectionId: keys.collectionId,
          FaceMatchThreshold: 95,
          Image: {
            S3Object: {
              Bucket: keys.bucketName,
              Name: `search/${user._id}`,
            },
          },
          MaxFaces: 1,
        };

        // Search face on Amazon Rekognition
        rekognition.searchFacesByImage(params, async (error, searchData) => {
          if (error) {
            return res.status(500).json({ error: 'Failed to searchFacesByImage in Rekognition' });
          }

          // get face Name from db
          let face;
          try {
            face = await db.collection('faces').findOne({ FaceId: searchData.FaceMatches[0].Face.FaceId });
          } catch (e) {
            return res.status(500).json({ error: 'Failed to retrieve face from DB' });
          }

          return res.status(200).json({ result: face.Name });
        });
      })(req, res, next);
    },
  );
};
