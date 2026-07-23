import db from "../config/db.js";

// 1. CREATE BOOKING FUNCTION (POST)
export const createBooking = (req, res) => {
  console.log("BODY =>", req.body);
  console.log("HEADERS =>", req.headers);
  const {
    user_id,
    artist_id,
    artist_name,
    service_id,
    booking_date,
    time_slot,
    address,
    total_price,
    notes,
    payment_method,
    payment_status,
    customer_name,
    customer_email,
    customer_phone,
    services
  } = req.body;

  const sql = `
    INSERT INTO bookings
    (
      user_id, artist_id, artist_name, service_id, booking_date, 
      time_slot, address, status, total_price, notes, 
      payment_method, payment_status, customer_name, customer_phone, services,customer_email
    )
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)`;

  const values = [
    user_id,
    artist_id,
    artist_name,
    service_id,
    booking_date,
    time_slot,
    address,
    "pending",
    total_price,
    notes,
    payment_method,
    payment_status,
    customer_name,
    customer_phone,
    JSON.stringify(services),
    customer_email,
  ];

  db.query(sql, values, (err, result) => {
    if (err) {
      console.log("MySQL Error:", err);
      return res.status(500).json({ success: false, message: err.message });
    }

    res.json({ success: true, message: "Booking Saved Successfully" });
  });
};

// 2. GET BOOKINGS FUNCTION (GET) - MySQL version
export const getBookings = (req, res) => {
  const { customer_phone } = req.query;
  
  let sql = "SELECT * FROM bookings";
  let values = [];
  
  // Agar phone number se search kiya hai
  if (customer_phone) {
    sql += " WHERE customer_phone = ?";
    values.push(customer_phone);
  }

  // Latest booking pehle
  sql += " ORDER BY booking_date DESC, time_slot DESC";

  db.query(sql, values, (err, results) => {
    if (err) {
      console.error("MySQL Error:", err);
      return res.status(500).json({ success: false, message: "Server error" });
    }
    
    res.status(200).json(results);
  });
};