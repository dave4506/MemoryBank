const Event = require('../models/Event')
const passport = require('passport');
const ObjectId = require('mongodb').ObjectID;

module.exports = (app, db) => {

    app.post(
      '/event/create',
      async (req, res, next) => {
            passport.authenticate('jwt', { session: false }, async (err, user) => {

                if (!req.body.event_name) {
                  return res.status(400).send({
                        message: "Must have event_name field."
                    });
                }

                if (!req.body.event_description) {
                  return res.status(400).send({
                        message: "Must have event_description field."
                    });
                }

                if (!req.body.event_location) {
                  return res.status(400).send({
                        message: "Must have event_location field."
                    });
                }

                if (!req.body.event_start_time) {
                  return res.status(400).send({
                        message: "Must have event_start_time field."
                    });
                }

                if (!req.body.event_end_time) {
                  return res.status(400).send({
                        message: "Must have event_end_time field."
                    });
                }

                const { event_name,
                    event_description,
                    event_location,
                    event_start_time,
                    event_end_time,
                    invited } = req.body;

                let new_event = null;
                try {
                    new_event = new Event(
                        user.displayName,
                        user._id,
                        event_name,
                        event_description,
                        event_location,
                        event_start_time,
                        event_end_time
                    )
                } catch (err) {
                    return res.status(500).json({ error: err.message });
                }

                let event_status;
                try {
                    event_status = await db.collection('events').insertOne(new_event);
                }
                catch (err) {
                    return res.status(500).json({ error: 'Internal server error, unable to store new event in the database.' });
                }
                if (event_status.result.ok != 1) {
                    return res.status(500).json({ error: 'Internal server error unable to store the new event in the database.' });
                }

                let event_id;
                if (event_status.insertedId !== 'undefined') {
                    event_id = event_status.insertedId
                }

                let update_status;
                try {
                    update_status = await db.collection('users').updateOne(
                        { _id: ObjectId(user._id) },
                        { $push: { events: ObjectId(event_id) } }
                    )
                }
                catch (err) {
                    console.log(err);
                    return res.status(500).json({error: 'Internal server error, unable to update status_id to user entry.'});
                }

                if (update_status.result.nModified != 1) {
                    return res.status(500).json({error: 'Internal server error, unable to add status_id to user entry.' });
                }

                try {
                    update_status = await db.collection('events').updateOne(
                        { _id: ObjectId(event_id) },
                        { $push: { users: ObjectId(user._id) } }
                    )
                }
                catch (err) {
                    return res.status(500).json({error: 'Internal server error, unable to add status_id to user entry.'});
                }
                if (update_status.result.nModified != 1) {
                    return res.status(500).json({error: 'Internal server error, unable to add status_id to user entry.' });
                }

                return res.status(200).json({ message: 'Successfully posted new status.' });
            })(req, res, next);
        }
    );

  app.post(
    '/event/share',
    async (req, res, next) => {
        passport.authenticate('jwt', { session: false }, async (err, user) => {

            if (!req.body.event_id) {
              return res.status(400).send({
                    message: "Must have event_id field."
                });
            }

            if (!req.body.user_id) {
              return res.status(400).send({
                    message: "Must have user_id field."
                });
            }

            const { event_id,
                user_id } = req.body;

            let update_status;
            try {
                update_status = await db.collection('users').updateOne(
                    { _id: ObjectId(user_id) },
                    { $push: { events: ObjectId(event_id) } }
                )
            }
            catch (err) {
                return res.status(500).json({error: 'Internal server error, unable to add status_id to user entry.'});
            }
            if (update_status.result.nModified != 1) {
                return res.status(500).json({error: 'Internal server error, unable to add status_id to user entry.' });
            }

            try {
                update_status = await db.collection('events').updateOne(
                    { _id: ObjectId(event_id) },
                    { $push: { users: ObjectId(user_id) } }
                )
            }
            catch (err) {
                return res.status(500).json({error: 'Internal server error, unable to add status_id to user entry.'});
            }
            if (update_status.result.nModified != 1) {
                return res.status(500).json({error: 'Internal server error, unable to add status_id to user entry.' });
            }

            return res.status(200).json({ message: 'Successfully posted new status.' });
        })(req, res, next);
    }
);

  app.post(
    '/event/delete/:event_id',
    async (req, res, next) => {
        passport.authenticate('jwt', { session: false }, async (err, user) => {
            if (!req.params.event_id) {
                return res.status(400).send({
                    message: "Must have event_id field."
                });
            }

            let event_info;

            try {
                event_info = await db.collection('events').findOne(
                    { _id: ObjectId(event_id) },
                    { projection: { users: 1} }
                );
            } catch (err) {
                return res.status(500).json({ error: 'Internal server error, unable to find user in the database.' });
            }

            event_info.users.map(friend_id => {
                db.collection('users').updateOne(
                    { _id: ObjectId(friend_id)},
                    { $pull: { events: ObjectId(event_id) }}
                );
            });

            let deletion_status;
            try {
                deletion_status = await db.collection('events').findOneAndDelete(
                    { _id: ObjectId(event_id) }
                );
            }
            catch (err) {
                return res.status(500).json({error: 'Internal server error. Unable to delete user from the database.'});
            }
            return res.status(200).json({ message: "successfully deleted event"});
        })(req, res, next);
    }
);

app.get(
  '/event/get/',
  async (req, res, next) => {
      passport.authenticate('jwt', { session: false }, async (err, user) => {

          console.log(user)

          let user_info;
          let event_ids = [];

          try {
              user_info = await db.collection('users').findOne(
                  { _id: ObjectId(user._id) },
                  { projection: { events: 1} }
              );
          } catch (err) {
              return res.status(500).json({ error: 'Internal server error, unable to find user in the database.' });
          }

          console.log(user_info);

          if (user_info) {
              event_ids.push(...user_info.events);
          }
          else {
              return res.status(500).json({ error: 'Unable to locate user profile.' });
          }

          async function GetEvents(event_ids) {
                let events = [];
                let eventsPromiseArray = await Promise.all(
                    event_ids.map(async event_id => {
                        try {
                            return db.collection('events').findOne(
                                { _id: ObjectId(event_id) }
                            );
                        }
                        catch (err) {}
                    })
                )
                eventsPromiseArray.forEach(event_ => {
                    events.push(event_);
                })
                return events;
            }

        GetEvents(event_ids)
        .then((event_objects) => {
            return res.status(200).json({ events: event_objects });
        })
      })(req, res, next);
  }
);

}
