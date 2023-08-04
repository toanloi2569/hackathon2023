const dotenv = require('dotenv')
dotenv.config({path: '.env', override: true})

exports.DATABASE_URL = process.env.DATABASE_URL
exports.OPENAI_API_KEY = process.env.OPENAI_API_KEY
console.log('config >> DATABASE_URL:',this.DATABASE_URL)
