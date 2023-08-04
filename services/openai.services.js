const config = require('../config/config');
const { Configuration, OpenAIApi } = require("openai");
const configuration = new Configuration({
    apiKey: config.OPENAI_API_KEY
});
const openai = new OpenAIApi(configuration);

async function complete(req, res) {
    prompt = req.body.prompt;
    console.log('openai.services >> prompt:',prompt);
    try {
        const gptResponse = await openai.createCompletion({
            model: "text-davinci-003",
            prompt: prompt,
            max_tokens: 2048,
            temperature: 0.9,
            top_p: 1,
            presence_penalty: 0.5,
            frequency_penalty: 0,
        });
        res.status(200).send({ data: gptResponse.data.choices[0].text })
    } catch (error) {
        console.log(error.message);
        res.status(500).send({ error: error?.message || 'Internal server error' })
    }
}

module.exports = {
    complete,
}
