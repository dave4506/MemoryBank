const authRoutes = require("./authRoutes");
const eventRoutes = require('./eventRoutes.js');
const messagingRoutes = require('./messagingRoutes.js');

module.exports = (app, db) => {
  authRoutes(app, db);

  // ======= Local ============
  eventRoutes(app, db);
  messsagingRotes(app, db);

  app.get(
    '/health_check',
    async (req, res, next) => {
      return res.status(200).json({ message: 'application is running' })
    }
  )
}
