import db from "../config/db.js";
console.log("Create Booking API Hit");
console.log(req.body);
export const createBooking = (req, res) => {

  const {
    user_id,
    artist_id,
    service_id,
    booking_date,
    time_slot,
    address,
    total_price,
    notes,
    payment_method,
    payment_status
  } = req.body;

  const sql = `
    INSERT INTO bookings
    (
      user_id,
      artist_id,
      service_id,
      booking_date,
      time_slot,
      address,
      status,
      total_price,
      notes,
      payment_method,
      payment_status
    )
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  `;

  db.query(
    sql,
    [
      user_id,
      artist_id,
      service_id,
      booking_date,
      time_slot,
      address,
      "pending",
      total_price,
      notes,
      payment_method,
      payment_status
    ],
    (err, result) => {

      if (err) {
        return res.status(500).json({
          success: false,
          message: err.message
        });
      }
      

      res.json({
        success: true,
        message: "Booking Saved Successfully",
        bookingId: result.insertId
      });

    }
  );

};