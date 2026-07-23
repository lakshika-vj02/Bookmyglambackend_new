import express from "express";
import { 
  getUsersCount, 
  getArtistsCount, 
  getServicesCount, 
  getTotalRevenue, 
  getAppointmentsStatus,
   deleteUser
  
} from "../controllers/adminController.js";
import { getUsers } from "../controllers/adminController.js";

const router = express.Router();

router.get("/users/count", getUsersCount);
router.get("/artists/count", getArtistsCount);
router.get("/services/count", getServicesCount);
router.get("/payments/total", getTotalRevenue);
router.get("/users", getUsers);
router.get("/appointments/status", getAppointmentsStatus);

//delete
router.delete("/users/:id", deleteUser);

export default router;
