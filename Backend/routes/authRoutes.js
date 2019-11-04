/* eslint no-underscore-dangle: ["error", { "allow": ["_id"] }] */

const passport = require('passport');
const validator = require('validator');
const { ObjectID } = require('mongodb');

const User = require('../models/User');
const authentication = require('../helpers/authentication');
const keys = require('../config/keys');

module.exports = (app, db) => {
  // ======= Local ============
  app.post(
    '/auth/signin',
    (req, res, next) => {
      passport.authenticate('local', { session: false }, async (err, user) => {
        // parse req.body
        if (!Object.prototype.hasOwnProperty.call(req.body, 'email')) {
          return res.status(400).json({ error: 'Incomplete request (missing email field)' });
        }
        if (!Object.prototype.hasOwnProperty.call(req.body, 'password')) {
          return res.status(400).json({ error: 'Incomplete request (missing password field)' });
        }

        // check for any errors in middleware
        if (err || !user) {
          return res.status(404).json({ error: err.message });
        }

        // Successful authentication, respond with token.
        let token;
        try {
          token = await authentication.tokenForUser(user);
        } catch (e) {
          return res.status(400).json({ error: e.message });
        }

        return res.status(200).json({ token });
      })(req, res, next);
    },
  );

  app.post(
    '/auth/signup',
    async (req, res) => {
      if (!Object.prototype.hasOwnProperty.call(req.body, 'email')) {
        return res.status(400).json({ error: 'incomplete request (missing email field)' });
      }
      if (!Object.prototype.hasOwnProperty.call(req.body, 'displayName')) {
        return res.status(400).json({ error: 'incomplete request (missing displayName field)' });
      }
      if (!Object.prototype.hasOwnProperty.call(req.body, 'password')) {
        return res.status(400).json({ error: 'incomplete request (missing password field)' });
      }

      const { email, displayName, password } = req.body;

      // error checking
      if (!email || !password || !displayName) {
        return res.status(400).json({ error: 'You must provide an email, a password, and a displayName' });
      }

      if (!validator.isEmail(email)) {
        return res.status(400).json({ error: 'incorrectly formatted email' });
      }

      // see if user with a given email exists
      let existingUser;
      try {
        existingUser = await db.collection('users').findOne({ email });
      } catch (err) {
        return res.status(500).json({ error: 'failed signup process on server' });
      }

      // if user does exist, return an error
      if (existingUser) {
        return res.status(409).json({ error: 'An user already exists with this email' });
      }

      // if user does not exist, create and save user record
      let user = null;
      try {
        user = new User(email, displayName, password);
      } catch (err) {
        return res.status(400).json({ error: err.message });
      }

      // store new user in DB
      try {
        await db.collection('users').insertOne(user);
      } catch (err) {
        return res.status(500).json({ error: 'failed to store new user to DB' });
      }

      return res.status(200).json({ message: 'User was succesfully created' });
    },
  );

  // ====== User ==================
  app.get(
    '/auth/user',
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
          return res.status(400).json({ error: err.message });
        }

        // Successful authentication, respond with user data
        const resUser = {
          email: user.email,
          displayName: user.displayName,
        };

        return res.status(200).json({ user: resUser });
      })(req, res, next);
    },
  );

  app.delete(
    '/auth/user',
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

        // delete user from db
        try {
          await db.collection('users').deleteOne({ _id: ObjectID(user._id) });
        } catch (error) {
          return res.status(200).json({ error: 'Could not delete user from DB' });
        }

        return res.status(200).json({ message: 'Succesfully deleted user' });
      })(req, res, next);
    },
  );

};
