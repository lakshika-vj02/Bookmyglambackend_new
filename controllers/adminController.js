import db from "../config/db.js";

// ✅ Get Total Users Count
export const getUsersCount = (req, res) => {
  db.query("SELECT COUNT(*) as count FROM users WHERE role = 'user'", (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ count: result[0].count });
  });
};

// ✅ Get Total Artists Count
export const getArtistsCount = (req, res) => {
  db.query("SELECT COUNT(*) as count FROM artists", (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ count: result[0].count });
  });
};

// ✅ Get Total Services Count
export const getServicesCount = (req, res) => {
  db.query("SELECT COUNT(*) as count FROM services", (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ count: result[0].count });
  });
};

// ✅ Get Total Revenue
export const getTotalRevenue = (req, res) => {
  db.query("SELECT SUM(amount) as total FROM payments WHERE payment_status = 'success'", (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ total: result[0].total || 0 });
  });
};

// ✅ Get Appointments Status Counts
export const getAppointmentsStatus = (req, res) => {
  const sql = `
    SELECT status, COUNT(*) as count 
    FROM bookings 
    GROUP BY status
  `;
  db.query(sql, (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    
    // Format into object { pending: 2, completed: 5, ... }
    const statusCounts = {};
    result.forEach(row => {
      statusCounts[row.status] = row.count;
    });
    
    res.json(statusCounts);
  });
};
// ✅ Get All Users
export const getUsers = (req, res) => {
  const sql = `
    SELECT id, name, email, phone_no, role, created_at
    FROM users
    WHERE role = 'user'
    ORDER BY id DESC
  `;

  db.query(sql, (err, result) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }

    res.json(result);
  });
};