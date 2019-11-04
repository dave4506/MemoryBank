module.exports = (app, db) => {

    app.post(
      '/event/create',
      async (req, res) => {
            if (!req.body.creator_username) {
              return res.status(400).send({
                    message: "Must have user_name field."
                });
            }

            if (!req.body.creator_id) {
              return res.status(400).send({
                    message: "Must have creator_id field."
                });
            }

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

            if (!req.body.evet_start_time) {
              return res.status(400).send({
                    message: "Must have evet_start_time field."
                });
            }

            if (!req.body.evet_end_time) {
              return res.status(400).send({
                    message: "Must have evet_end_time field."
                });
            }

            if (!req.body.invited) {
              return res.status(400).send({
                    message: "Must have invited field."
                });
            }

            const { creator_username,
                creator_id,
                event_name,
                event_description,
                event_location,
                evet_start_time,
                evet_end_time,
                invited } = req.body;



        }
    );

  app.post(
    '/event/share',
    async (req, res, next) => {
      return res.status(200).json({ message: 'application is running' })
    }
);

  app.post(
    '/event/delete/:event_id',
    async (req, res, next) => {
      return res.status(200).json({ message: 'application is running' })
    }
);

}
