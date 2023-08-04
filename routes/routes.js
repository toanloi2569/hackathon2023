const openai = require('../services/openai.services');

module.exports = function(app) {
    app.use(function(req, res, next) {
        res.header(
            "Access-Control-Allow-Headers",
            "x-access-token, Origin, Content-Type, Accept"
        );
        next();
    });

    // complete openai
    app.post('/api/complete', openai.complete);
}
