const dotenv = require('dotenv')
dotenv.config({path: '.env', override: true})

exports.DATABASE_URL = process.env.DATABASE_URL
console.log('config >> DATABASE_URL:',this.DATABASE_URL)
