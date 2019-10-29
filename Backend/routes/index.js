module.exports = (app) => {
  // ======= Local ============
  app.get(
    '/health_check',
    async (req, res, next) => {
      return res.status(200).json({ message: 'application is running '})
    }
  );


};
