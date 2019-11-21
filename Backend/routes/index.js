const authRoutes = require('./authRoutes');
const eventRoutes = require('./eventRoutes.js');
const s3Routes = require('./s3Routes');

module.exports = (app, db) => {
  authRoutes(app, db);

  // ======= Local ============
  eventRoutes(app, db);
  s3Routes(app, db);

  app.get(
    '/health_check',
    async (req, res, next) => {
      return res.status(200).json({ message: 'application is running' })
    }
  )
}
