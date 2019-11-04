const ObjectId = require('mongodb').ObjectID;

class Event {
  constructor(creator_username, creator_id, _event_name, _event_description, _event_location, _event_start_time, _event_end_time) {
      this.creator_username = _creator_username;
      this.creator_id = ObjectId(_creator_id);
      this.event_name = _event_name;
      this.event_description = _event_description;
      this.event_location = _event_location;
      this.evet_start_time = _evet_start_time;
      this.event_end_time = _event_end_time;
      this.invites = []
  }
}

module.exports = Event;
