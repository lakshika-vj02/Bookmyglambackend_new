import express from "express";
import { 
  getUsersCount, 
  getArtistsCount, 
  getServicesCount, 
  getTotalRevenue, 
  getAppointmentsStatus,
   deleteUser,
   getUsers,
    getAllBookings,
  updateBookingStatus
  
} from "../controllers/adminController.js";

const router = express.Router();

router.get("/users/count", getUsersCount);
router.get("/artists/count", getArtistsCount);
router.get("/services/count", getServicesCount);
router.get("/payments/total", getTotalRevenue);
router.get("/users", getUsers);
router.get("/appointments/status", getAppointmentsStatus);
router.get("/bookings", getAllBookings);
router.put("/bookings/:id", updateBookingStatus);

//delete
router.delete("/users/:id", deleteUser);

export default router;
