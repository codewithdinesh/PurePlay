/* Author: SANJU BODRA */

const express = require("express");
const cors = require('cors');
const { connectDB } = require("./config/db");

const app = express();

const authRoutes = require("./routes/authRoutes");
const creatorRoutes = require("./routes/creatorRoutes");
const walletRoutes = require("./routes/walletRoutes");
const subscriptionRoutes = require("./routes/subscriptionRoutes");

async function main() {
  // Environment variables
  require("dotenv").config();

  // Mibbleware configuration
  app.use(cors())
  app.use(express.json());

  app.use(express.urlencoded({
    extended: false
  }))

  // Connect to Database
  try {
    await connectDB();
    console.log('Connected to the database');
  } catch (error) {
    console.error('Failed to connect to the database:', error.message);
    process.exit(1); // Exit the process if unable to connect to the database
  }
}

main();




app.get("/", (req, res, next) => {
  res.status(200).json({
    message: "Hello World",
  });
});

//Auth Routes
app.use("/auth/v1", [authRoutes]);

//Routes
app.use("/api/v1", [creatorRoutes, walletRoutes, subscriptionRoutes]);

app.listen(3000|| process.env.PORT, () => {
  console.log(`Server is running on port ${process.env.PORT}`);
});
