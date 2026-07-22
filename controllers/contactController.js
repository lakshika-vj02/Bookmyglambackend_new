const db = require("../config/db");

const getContact = (req, res) => {

    const sql = "SELECT * FROM contact";

    db.query(sql, (err, result) => {

        if(err){
            return res.status(500).json(err);
        }

        res.json(result);

    });

};

module.exports = { getContact };