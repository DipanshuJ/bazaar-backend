const express = require('express');
const error = require("./middleware/error");
const app = express();
const cookieParser = require("cookie-parser");

// Configuration of PROCESS.ENV
if (process.env.NODE_ENV !== "PRODUCTION") {
    require("dotenv").config({ path: "config/config.env" });
}

app.use(express.json());
app.use(cookieParser());

//Route Imports
const user = require("./routes/userRoute");
const product = require("./routes/productRoute");
const home = require('./routes/homeRoute');
const order = require("./routes/orderRoute");

app.use("/api", user);
app.use("/api", product);
app.use("/api", home);
app.use("/api", order);




app.use(error);

module.exports = app;