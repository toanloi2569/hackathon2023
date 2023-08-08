const { DataSource } = require("typeorm")
const { SqlDatabase } = require("langchain/sql_db")

let blank_db_conn = null;
let db_conn = null;

const get_blank_db_conn = async() => {
    if (blank_db_conn) {
        return blank_db_conn;
    }

    const datasource = new DataSource({
        type: "postgres",
        host: "db.tmorcdhbdxntahnhrvmh.supabase.co",
        port: 5432,
        username: "postgres",
        password: "Hackathon2023",
        database: "postgres",
        schema: "blank"
    })

    blank_db_conn = await SqlDatabase.fromDataSourceParams({
        appDataSource: datasource,
    })
    return blank_db_conn;
}

const get_db_conn = async() => {
    if (db_conn) {
        return db_conn;
    }

    const datasource = new DataSource({
        type: "postgres",
        host: "db.tmorcdhbdxntahnhrvmh.supabase.co",
        port: 5432,
        username: "postgres",
        password: "Hackathon2023",
        database: "postgres",
        schema: "public"
    })

    db_conn = await SqlDatabase.fromDataSourceParams({
        appDataSource: datasource,
    })
    return db_conn;
}


module.exports = {
    get_db_conn,
    get_blank_db_conn
}
