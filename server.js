// import express from "express";
// import cors from "cors";
// import dotenv from "dotenv";

// import authRoutes from "./routes/authRoutes.js";
// import adminRoutes from "./routes/adminRoutes.js";
// import serviceRoutes from "./routes/serviceRoutes.js";
// import artistRoutes from "./routes/artistRoutes.js";
// import bookingRoutes from "./routes/bookingRoutes.js";
// import path from "path";
// import { fileURLToPath } from "url";
// import db from "./config/db.js";
// import { getSubcategory, getSubcategoryItems } from "./controllers/serviceController.js";

// // Auto-migrate missing column
// db.query(
//   "ALTER TABLE bookings ADD COLUMN customer_email VARCHAR(150)",
//   (err) => {
//     if (err && err.code !== 'ER_DUP_FIELDNAME') {
//       console.log("Migration Note: customer_email column might already exist or DB is unavailable yet.");
//     } else if (!err) {
//       console.log("Migration Success: Added customer_email column to bookings table.");
//     }
//   }
// );

// const __filename = fileURLToPath(import.meta.url);
// const __dirname = path.dirname(__filename);

// dotenv.config();

// const app = express();

// app.use(cors());
// app.use(express.json());

// // ── ROUTES ──────────────────────────────────────────────────
// app.use("/api", authRoutes);
// app.use("/api/admin", adminRoutes);

// app.use("/services", serviceRoutes);

// app.use("/artists", artistRoutes);
// app.use("/bookings", bookingRoutes);

// // Frontend calls: GET /subcategory/:serviceId  → Level 2 subcategories
// app.get("/subcategory/:serviceId", getSubcategory);

// // Frontend calls: GET /subcategory-items/:subcategoryId  → Level 3 items
// app.get("/subcategory-items/:subcategoryId", getSubcategoryItems);

// // Static images
// app.use("/images", express.static(path.join(__dirname, "images")));
// // ── ERROR HANDLER ────────────────────────────────────────────
// app.use((err, req, res, next) => {

//   console.error("🔥 ERROR:", err);

//   res.status(500).json({
//     success: false,
//     message: err.message || "Internal Server Error"
//   });
// app.get("/test", (req, res) => {
//   res.send("Server Working");
// });
// });


// app.listen(process.env.PORT, () => {

//   console.log(
//     `🚀 Server running on port ${process.env.PORT}`
//   );

// });



// // ── ERROR HANDLER ────────────────────────────────────────────
// app.use((err, req, res, next) => {

//   console.error("🔥 ERROR:", err);

//   res.status(500).json({
//     success: false,
//     message: err.message || "Internal Server Error"
//   });

// });


// app.listen(process.env.PORT, () => {

//   console.log(
//     `🚀 Server running on port ${process.env.PORT}`
//   );

// });
import express from "express";
import cors from "cors";
import dotenv from "dotenv";

import authRoutes from "./routes/authRoutes.js";
import adminRoutes from "./routes/adminRoutes.js";
import serviceRoutes from "./routes/serviceRoutes.js";
import artistRoutes from "./routes/artistRoutes.js";
import bookingRoutes from "./routes/bookingRoutes.js";

import path from "path";
import { fileURLToPath } from "url";
import db from "./config/db.js";
import {
  getSubcategory,
  getSubcategoryItems,
} from "./controllers/serviceController.js";

dotenv.config();

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

app.use(cors());
app.use(express.json());

// Auto Migration
db.query(
  "ALTER TABLE bookings ADD COLUMN customer_email VARCHAR(150)",
  (err) => {
    if (err && err.code !== "ER_DUP_FIELDNAME") {
      console.log("Migration Note:", err.message);
    }
  }
);

// Routes
app.use("/api", authRoutes);
app.use("/api/admin", adminRoutes);
app.use("/services", serviceRoutes);
app.use("/artists", artistRoutes);
app.use("/bookings", bookingRoutes);

app.get("/subcategory/:serviceId", getSubcategory);
app.get("/subcategory-items/:subcategoryId", getSubcategoryItems);

// Static Images
app.use("/images", express.static(path.join(__dirname, "images")));

// Test Route
app.get("/test", (req, res) => {
  res.send("Server Working");
});

// Error Handler
app.use((err, req, res, next) => {
  console.error(err);

  res.status(500).json({
    success: false,
    message: err.message,
  });
});

// Server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${process.env.PORT}`);
});