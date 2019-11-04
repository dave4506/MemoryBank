const validator = require('validator');
const uuidv4 = require('uuid/v4');
const crypto = require('crypto');

class User {
  constructor(_email, _displayName, _password) {
    if (!_email || !_displayName || !_password) {
      throw Error('missing fields');
    }

    if (!validator.isEmail(_email)) {
      throw Error('invalid email input');
    }

    this.email = _email;
    this.displayName = _displayName;
    this.salt = uuidv4();
    const key = crypto.pbkdf2Sync(_password, this.salt, 100000, 512, 'sha512');
    this.password = key.toString('hex');
  }
}

module.exports = User;
