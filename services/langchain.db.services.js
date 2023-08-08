const { OpenAI } = require("langchain/llms/openai")
const { SqlDatabaseChain } = require("langchain/chains/sql_db")
const { PromptTemplate } = require("langchain/prompts")
const { get_db_conn, get_blank_db_conn } = require("./database.services")
const config = require("../config/config");


const promptTemplateRaw = `
Given an input chat, first verify the chat is query something on Database or not. If yes, first create a syntactically correct SQL query. If not, you should chat the Answer as professional assistant.
Use the following format to response:

SQLQuery: "SQL Query to run" (If is SQL query question, If not then not show SQLQuery)
SQLResult: "Result of the SQLQuery" (If is SQL query question. If not then not show SQLResult)
Answer: "Final chat answer here" (If having SQL Query then anser the result with professional sumarize text. Otherwise you can answer the chat with your knowledge as professional assistant. You must answer every chat in Vietnamese.)

{question}
`

const promptTemplate = PromptTemplate.fromTemplate(promptTemplateRaw)

async function chat(req, res) {
    const question = req.body.question;
    const chain = new SqlDatabaseChain({
        llm: new OpenAI({
            modelName: "gpt-3.5-turbo",
            temperature: 0,
            openAIApiKey: config.OPENAI_API_KEY,
        }),
        database: await get_blank_db_conn(),
    })
    const prompt = await promptTemplate.format({
        question: question,
    })

    try {
        const sqlQuery = await chain.run(prompt);
        res.status(200).send({ data: sqlQuery })
    } catch (error) {
        console.log(error.message);
        res.status(500).send({ error: error?.message || 'Internal server error' })
    }
}

module.exports = {
    chat,
}
