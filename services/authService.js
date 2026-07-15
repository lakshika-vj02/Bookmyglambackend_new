import db from "../config/db.js";

// ✅ REGISTER USER
export const registerUser = (name, email, password, gender, phone_no, role, callback) => {
  const sql = `
    INSERT INTO users (name, email, password, gender, phone_no, role)
    VALUES (?, ?, ?, ?, ?, ?)
  `;

  db.query(sql, [name, email, password, gender, phone_no, role], (err, result) => {
    
    if (err) {
      console.log("🔥 DB REGISTER ERROR:", err); // 🔥 DEBUG LINE
      return callback(err, null);
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