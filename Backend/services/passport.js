const crypto = require('crypto');
const { ExtractJwt } = require('passport-jwt');
const JwtStrategy = require('passport-jwt').Strategy;
const LocalStrategy = require('passport-local');

const keys = require('../config/keys');

class Strategies {
  constructor(_db) {
    this.db = _db;

    // ============== Local Strategy ======================
    this.localLogin = new LocalStrategy(
      {
        usernameField: 'email',
      },
      async (email, password, done) => {
        let existingUser;
        try {
          existingUser = await this.db.collection('users').findOne({ email });
        } catch (err) {
          return done(err, null);
        }

        if (!existingUser) {
          return done(Error('The provided email does not pertain to any user'), null);
        }

        const key = crypto.pbkdf2Sync(password, existingUser.salt, 100000, 512, 'sha512');
        const hashedPassword = key.toString('hex');

        if (hashedPassword !== existingUser.password) {
          return done(Error('incorrect password'), null);
        }

        return done(null, existingUser);
      },
    );

    // ============== JWT Strategy ======================
    this.jwtLogin = new JwtStrategy(
      {
        jwtFromRequest: ExtractJwt.fromHeader('authorization'),
        secretOrKey: keys.jwtSecret,
      },
      async (payload, done) => {
        // See if the user in payload exist in DB
        let existingUser;
        try {
          existingUser = await this.db.collection('users').findOne({ email: payload.data.email });
        } catch (err) {
          return done(Error('server failed accesing user from DB'), false);
        }

        if (existingUser) {
          return done(null, existingUser);
        }

        return done(Error('User id does not match anyone in our database'), false);
      },
    );
  }
}

module.exports = Strategies;
