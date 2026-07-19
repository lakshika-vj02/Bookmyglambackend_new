import express from "express";
import { 
  getUsersCount, 
  getArtistsCount, 
  getServicesCount, 
  getTotalRevenue, 
  getAppointmentsStatus 
} from "../controllers/adminController.js";

const router = express.Router();

router.get("/users/count", getUsersCount);
router.get("/artists/count", getArtistsCount);
router.get("/services/count", getServicesCount);
router.get("/payments/total", getTotalRevenue);
router.get("/appointments/status", getAppointmentsStatus);

export default router;
