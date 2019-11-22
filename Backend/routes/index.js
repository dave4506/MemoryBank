const authRoutes = require('./authRoutes');
const eventRoutes = require('./eventRoutes');
const s3Routes = require('./s3Routes');
const rekognitionRoutes = require('./rekognitionRoutes');

module.exports = (app, db, AWS) => {
  // ======= Routes =========
  authRoutes(app, db);
  eventRoutes(app, db);
  s3Routes(app, AWS);
  rekognitionRoutes(app, db, AWS);

  app.get(
    '/health_check',
    async (req, res) => {
      return res.status(200).json({ message: 'application is running' })
    }
  )
}
