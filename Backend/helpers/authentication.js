/* eslint no-underscore-dangle: ["error", { "allow": ["_id"] }] */

const jwt = require('jsonwebtoken');

const keys = require('../config/keys');

exports.tokenForUser = async (user) => {
  let token;
  try {
    token = await jwt.sign({
      data: {
        id: user._id,
        email: user.email,
        displayName: user.displayName,
      },
    }, keys.jwtSecret, { expiresIn: 60 * 60 });
  } catch (err) {
    throw Error('Could not create token for user');
  }
  return token;
};
