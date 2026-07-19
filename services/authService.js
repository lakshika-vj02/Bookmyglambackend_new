import db from "../config/db.js";

// ✅ REGISTER USER
export const registerUser = (name, email, password, gender, phone_no, role, callback) => {
  const sql = `
    INSERT INTO users (name, email, password, gender, phone_no, role)
    VALUES (?, ?, ?, ?, ?, ?)
  `;

  db.query(sql, [name, email, password, gender, phone_no, role], (err, result) => {
    if (err) {
      console.log("🔥 DB REGISTER ERROR:", err);
      return callback(err, null);
    }

    if (role === 'artist') {
      const artistSql = `
        INSERT INTO artists (name, email, phone, gender, user_id)
        VALUES (?, ?, ?, ?, ?)
      `;
      db.query(artistSql, [name, email, phone_no, gender, result.insertId], (err2) => {
        if (err2) console.log("🔥 DB ARTIST INSERT ERROR:", err2);
      });
    }

    return callback(null, result);
  });
};


// ✅ LOGIN USER
export const loginUser = (email, password, callback) => {
  const sql = `
    SELECT * FROM users 
    WHERE email = ? AND password = ?
  `;

  db.query(sql, [email, password], (err, result) => {
    
    if (err) {
      console.log("🔥 DB LOGIN ERROR:", err); // 🔥 DEBUG LINE
      return callback(err, null);
    }

    return callback(null, result);
  });
};