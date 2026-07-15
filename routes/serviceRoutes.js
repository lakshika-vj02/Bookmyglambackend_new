import express from "express";
import { getServices, getSubcategory } from "../controllers/serviceController.js";

const router = express.Router();

// GET /services          → all services
// GET /services?category=Bridal Makeup → filtered
router.get("/", getServices);

export default router;