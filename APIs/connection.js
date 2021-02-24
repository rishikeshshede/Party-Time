const mysql = require("mysql");
var mysqlConnection = mysql.createConnection({
    host: "localhost",
    user: "dummyUser",
    password: "dummyPass",
    database: "bookario_database",
    port: 3306
});


mysqlConnection.connect((error) => {
    if (!error) {
        console.log("Connected");
    } else {
        console.log("Connection failed " + error.code);
    }
});

module.exports = mysqlConnection;
