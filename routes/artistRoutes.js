import express from "express";
import db from "../config/db.js";

const router = express.Router();


// ── GET ALL ARTISTS ──────────────────────────────────────────
router.get("/", (req, res) => {

  db.query("SELECT * FROM artists", (err, result) => {

    if (err) {
      console.log(err);
      return res.status(500).json({ success: false, message: "Database Error" });
    }

    const baseUrl = `${req.protocol}://${req.get("host")}/images/`;
    const artistsWithImages = result.map(artist => ({
      ...artist,
      profile_image: artist.profile_image
        ? (artist.profile_image.startsWith("http")
            ? artist.profile_image
            : `${baseUrl}${artist.profile_image}`)
        : null
    }));

    res.json(artistsWithImages);

  });

});


// ── GET SERVICES OF A SPECIFIC ARTIST ────────────────────────
// Uses artist's specialty to match service category directly


  // Step 1: get the artist's specialty
//   db.query("SELECT * FROM artists WHERE id = ?", [id], (err, artistResult) => {

//     if (err) {
//       console.log(err);
//       return res.status(500).json({ success: false, message: "Database Error" });
//     }

//     if (artistResult.length === 0) {
//       return res.status(404).json({ success: false, message: "Artist not found" });
//     }

//     const specialty = artistResult[0].specialty;

//     // Step 2: return services whose category matches the specialty
//     db.query(
//       "SELECT * FROM services WHERE category = ? AND active = 1",
//       [specialty],
//       (err2, servicesResult) => {

//         if (err2) {
//           console.log(err2);
//           return res.status(500).json({ success: false, message: "Database Error" });
//         }

//         const baseUrl = `${req.protocol}://${req.get("host")}/images/`;
//         const servicesWithImages = servicesResult.map(service => ({
//           ...service,
//           image: service.image
//             ? (service.image.startsWith("http")
//                 ? service.image
//                 : `${baseUrl}${service.image}`)
//             : null
//         }));

//         res.json(servicesWithImages);

//       }
//     );

//   });

// });
router.get("/:id/services", (req, res) => {

  const { id } = req.params;

  const sql = `
    SELECT
      s.id,
      s.subcategory_name,
      s.description,
      s.price,
      s.duration,
      s.image
    FROM artist_services ars
    JOIN service_subcategories s
      ON ars.service_id = s.service_id
    WHERE ars.artist_id = ?;
  `;

  db.query(sql, [id], (err, result) => {

    if (err) {
      console.log(err);
      return res.status(500).json({
        success: false,
        message: "Database Error"
      });
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

});


// ── GET ARTIST BY USER ID (For Artist Dashboard) ─────────────
router.get("/by-user/:userId", (req, res) => {
  const { userId } = req.params;
  db.query("SELECT * FROM artists WHERE user_id = ?", [userId], (err, result) => {
    if (err) return res.status(500).json({ success: false, message: "DB Error" });
    if (result.length === 0) return res.status(404).json({ success: false, message: "Artist not found" });
    
    // Add image url formatting
    const artist = result[0];
    const baseUrl = `${req.protocol}://${req.get("host")}/images/`;
    if (artist.profile_image && !artist.profile_image.startsWith("http")) {
      artist.profile_image = `${baseUrl}${artist.profile_image}`;
    }
    
    res.json({ success: true, artist });
  });
});


// ── UPDATE ARTIST PROFILE (Price, Bio, Specialty) ────────────
router.put("/:id", (req, res) => {
  const { id } = req.params;
  const { bio, specialty, base_price, phone } = req.body;
  
  const sql = `
    UPDATE artists 
    SET bio = ?, specialty = ?, base_price = ?, phone = ?
    WHERE id = ?
  `;
  
  db.query(sql, [bio, specialty, base_price, phone, id], (err, result) => {
    if (err) return res.status(500).json({ success: false, message: "DB Error" });
    res.json({ success: true, message: "Profile updated successfully" });
  });
});

export default router;