const openAIServices = require('../services/openai.services');
const langchainDBServices = require('../services/langchain.db.services');

module.exports = function(app) {
    app.use(function(req, res, next) {
        res.header(
            "Access-Control-Allow-Headers",
            "x-access-token, Origin, Content-Type, Accept"
        );
        next();
    });

    // complete openai
    app.post('/api/complete', openAIServices.complete);

    // chat langchain
    app.post('/api/chat', langchainDBServices.chat);
}
