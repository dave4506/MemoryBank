const Event = require('../models/Event')
const passport = require('passport');
const ObjectId = require('mongodb').ObjectID;

module.exports = (app, db) => {
  app.post(
    '/messaging/send',
    async (req, res, next) => {
          passport.authenticate('jwt', { session: false }, async (err, user) => {

              if (!req.body.receiver_email) {
                return res.status(400).send({
                      message: "Must have receiver_email field."
                  });
              }

              if (!req.body.message) {
                return res.status(400).send({
                      message: "Must have message field."
                  });
              }

              const { receiver_email,
                  message } = req.body;

              new_message = {}

              new_message['sender_email'] = user.email;
              new_message['receiver_email'] = receiver_email;
              new_message['message'] = message;

              let update_status;
              try {
                  update_status = await db.collection('users').updateOne(
                      { email: receiver_email },
                      { $push: { messages: new_message } }
                  )
              }
              catch (err) {
                  return res.status(500).json({error: 'Internal server error, unable to add status_id to user entry.'});
              }
              if (update_status.result.nModified != 1) {
                  return res.status(500).json({error: 'Internal server error, unable to add status_id to user entry.' });
              }

              return res.status(200).json({ message: 'Successfully sent new message.' });

          })(req, res, next);
      }
  );

  app.get(
    '/messaging/get',
    async (req, res, next) => {
          passport.authenticate('jwt', { session: false }, async (err, user) => {

              user_messages = {};

              try {
                  user_messages = await db.collection('users').findOne(
                      { email: user.email },
                      { projection: { messages: 1} }
                  );
              } catch (err) {
                  return res.status(500).json({ error: 'Internal server error, unable to find user in the database.' });
              }

              return res.status(200).json({ messages: user_messages });

          })(req, res, next);
      });
}
