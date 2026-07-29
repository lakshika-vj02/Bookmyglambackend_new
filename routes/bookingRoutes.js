import express from "express";
import { createBooking, getBookings , cancelBooking,} from "../controllers/bookingController.js"; 

const router = express.Router();

router.post("/", createBooking);
router.get("/", getBookings);
router.put("/:id/cancel", cancelBooking);

export default router;