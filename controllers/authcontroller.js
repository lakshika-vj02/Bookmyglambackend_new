import { loginUser, registerUser } from "../services/authService.js";

// ✅ LOGIN
export const login = (req, res, next) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({
      success: false,
      message: "All fields are required"
    });
  }

  loginUser(email, password, (err, result) => {
    if (err) return next(err); // 🔥 IMPORTANT

    if (result.length > 0) {
      const user = result[0];
      return res.json({
        success: true,
        role: user.role,
        userId: user.id,
        name: user.name,
        email: user.email
      });
    } else {
      return res.status(401).json({
        success: false,
        message: "Invalid Email or Password"
      });
    }
  });
};


// ✅ SIGNUP
export const signup = (req, res, next) => {
  const { name, email, password, gender, phone_no, role } = req.body;

  if (!name || !email || !password || !gender || !phone_no || !role) {
    return res.status(400).json({
      success: false,
      message: "All fields are required"
    });
  }

  registerUser(name, email, password, gender, phone_no, role, (err) => {
    if (err) {
      if (err.code === "ER_DUP_ENTRY") {
        return res.status(400).json({
          success: false,
          message: "Email already exists"
        });
      }

      return next(err); // 🔥 IMPORTANT
    }

    return res.json({
      success: true,
      message: "Signup Successful"
    });
  });
}