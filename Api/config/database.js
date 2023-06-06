const { createPool } = require('mysql2');

const pool = createPool({
    host: "localhost",
    user: "root",
    password: "",
    database: "hackathon_iic"
});

module.exports = pool;

// module.exports = pool;