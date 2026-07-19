import express from "express";
import cors from "cors";
import dotenv from "dotenv";

import authRoutes from "./routes/authRoutes.js";
import adminRoutes from "./routes/adminRoutes.js";
import serviceRoutes from "./routes/serviceRoutes.js";
import artistRoutes from "./routes/artistRoutes.js";
import path from "path";
import { fileURLToPath } from "url";
import db from "./config/db.js";
import { getSubcategory, getSubcategoryItems } from "./controllers/serviceController.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

dotenv.config();

const app = express();

app.use(cors());
app.use(express.json());

// ── ROUTES ──────────────────────────────────────────────────
app.use("/api", authRoutes);
app.use("/api/admin", adminRoutes);

app.use("/services", serviceRoutes);

app.use("/artists", artistRoutes);

// Frontend calls: GET /subcategory/:serviceId  → Level 2 subcategories
app.get("/subcategory/:serviceId", getSubcategory);

// Frontend calls: GET /subcategory-items/:subcategoryId  → Level 3 items
app.get("/subcategory-items/:subcategoryId", getSubcategoryItems);

// Static images
app.use("/images", express.static(path.join(__dirname, "images")));


// ── ERROR HANDLER ────────────────────────────────────────────
app.use((err, req, res, next) => {

  console.error("🔥 ERROR:", err);

  res.status(500).json({
    success: false,
    message: err.message || "Internal Server Error"
  });

});


app.listen(process.env.PORT, () => {

  console.log(
    `🚀 Server running on port ${process.env.PORT}`
  );

});