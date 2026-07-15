# Fortnightly Progress Report 3
**Project Name:** BookMyGlam (Backend Development)
**Module/Focus:** Artists & Services Management API

## 1. Objectives of the Fortnight
* To develop endpoints for fetching and managing service providers (Artists).
* To implement APIs for retrieving beauty and glamour services.
* To manage static files (images) and generate dynamic asset URLs.

## 2. Work Completed
* **Artists Module:**
  * Created `artistRoutes.js` to manage artist-related data.
  * Implemented the **GET All Artists API** which queries the `artists` table in the database and returns the data in JSON format.
  * Added logic to dynamically construct and attach `profile_image` URLs for each artist using the request protocol and host (`req.protocol` and `req.get("host")`).
* **Services Module:**
  * Created `serviceRoutes.js` and `serviceController.js` to handle data regarding the services provided on the platform.
* **Refactoring:** Improved the structure by keeping routes (`routes/`) and business logic (`controllers/`) separate, leading to a cleaner architecture.

## 3. Challenges Faced
* Handling relative vs. absolute URLs for image assets. This was resolved by conditionally formatting the `profile_image` string depending on whether it already starts with 'http' or needs the base server URL appended.

## 4. Plan for Next Fortnight
* Develop booking/appointment logic to allow users to schedule services with artists.
* Implement user profile management endpoints.
* Work on securing the endpoints with JWT (JSON Web Tokens) or session-based middleware.
