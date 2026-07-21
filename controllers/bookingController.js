import db from "../config/db.js";

export const createBooking = (req, res) => {
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
  customer_phone,
  services
} = req.body;

const sql = `
  INSERT INTO bookings
(
  user_id,
  artist_id,
  artist_name,
  service_id,
  booking_date,
  time_slot,
  address,
  status,
  total_price,
  notes,
  payment_method,
  payment_status,
  customer_name,
  customer_phone,
  services
)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;

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
  JSON.stringify(services)
];
console.log("SQL Query:");
console.log(sql);

console.log("Values:");
console.log(values); 
  // Store the query instance so we can inspect it
  db.query(sql, values, (err, result) => {
   if (err) {
    console.log("MySQL Error:", err);
    console.log("SQL:", sql);
    console.log("Values:", values);

    return res.status(500).json({
      success: false,
      message: err.message
    });
  }

  res.json({
    success: true,
    message: "Booking Saved Successfully"
  });
});
}