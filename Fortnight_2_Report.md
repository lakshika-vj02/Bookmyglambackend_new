# Fortnightly Progress Report 2
**Project Name:** BookMyGlam (Backend Development)
**Module/Focus:** Database Integration & User Authentication

## 1. Objectives of the Fortnight
* To set up and configure the MySQL database connection.
* To design the user schema and implement user authentication.
* To develop robust RESTful APIs for login and signup functionality.

## 2. Work Completed
* **Database Configuration:** Configured the database connection (`db.js`) to interact with `bookmyglam_db.sql`.
* **Authentication System:** 
  * Developed `authRoutes.js` and `authcontroller.js` to handle user login and registration.
  * Implemented the **Signup API** with validation for required fields (name, email, password, gender, phone_no, role) and duplicate email checking (`ER_DUP_ENTRY`).
  * Implemented the **Login API** with role-based access checking and validation for invalid credentials.
* **Error Handling:** Integrated global error handling in the controllers to ensure smooth responses and prevent server crashes during authentication flows.

## 3. Challenges Faced
* Handling asynchronous database queries and ensuring proper error propagation for duplicate user entries.
* Managing secure responses and validating required parameters consistently across API endpoints.

## 4. Plan for Next Fortnight
* Begin development of the Artists and Services modules.
* Create endpoints to fetch and manage service providers (artists) and the services they offer.
* Implement dynamic image URL configurations for artist profiles.
