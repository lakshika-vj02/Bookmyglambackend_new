import express from "express";
const router = express.Router();
import db from "../config/db.js";



router.post("/", (req, res) => {
  console.log(req.body);

  res.json({
    success: true,
    message: "Booking Saved"
  });
});

export default router;