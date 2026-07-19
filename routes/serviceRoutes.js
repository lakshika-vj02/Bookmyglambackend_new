import express from "express";
import { getServices, getSubcategory, getSubcategoryItems } from "../controllers/serviceController.js";

const router = express.Router();

// GET /services              → all services
// GET /services?category=Hair → filtered by category
router.get("/", getServices);

// GET /services/:serviceId/subcategories → subcategories of a service
router.get("/:serviceId/subcategories", getSubcategory);

// GET /services/:serviceId/subcategories/:subcategoryId/items → items of a subcategory
router.get("/:serviceId/subcategories/:subcategoryId/items", getSubcategoryItems);

export default router;