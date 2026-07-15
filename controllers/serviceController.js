import db from "../config/db.js";

// ── GET ALL SERVICES (with optional ?category= filter) ───────
export const getServices = (req, res) => {

  const { category } = req.query;

  let sql = "SELECT * FROM services";
  let values = [];

  if (category) {
    sql += " WHERE category = ?";
    values.push(category);
  }

  db.query(sql, values, (err, result) => {

    if (err) {
      console.log(err);
      return res.status(500).json(err);
    }

    const baseUrl = `${req.protocol}://${req.get("host")}/images/`;
    const servicesWithImages = result.map(service => ({
      ...service,
      image: service.image
        ? (service.image.startsWith("http")
            ? service.image
            : `${baseUrl}${service.image}`)
        : null
    }));

    res.json(servicesWithImages);

  });

};

// ── GET SUBCATEGORIES ─────────────────────────────────────────
// Given a serviceId, fetch all subcategories from service_subcategory table
export const getSubcategory = (req, res) => {

  const { serviceId } = req.params;

  // Query the actual service_subcategories table
  const sql = "SELECT * FROM service_subcategories WHERE service_id = ?";

  db.query(sql, [serviceId], (err, result) => {

    if (err) {
      console.log(err);
      return res.status(500).json({ success: false, message: "Database Error", error: err.message });
    }

    const baseUrl = `${req.protocol}://${req.get("host")}/images/`;
    const subcategoriesWithImages = result.map(item => ({
      ...item,
      image: item.image
        ? (item.image.startsWith("http")
            ? item.image
            : `${baseUrl}${item.image}`)
        : null
    }));

    res.json(subcategoriesWithImages);

  });

};