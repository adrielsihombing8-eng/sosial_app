const componentController = require("../controller/countComponen.controller");
const express = require("express").Router();
const auth = require("../controller/authController");

express.post("/firstDatas", auth.auth, componentController.firstDatas);
express.post("/:postId/loadDatas", auth.auth, componentController.loadDatas);
express.post("/:postId/addView", auth.auth, componentController.addView);

module.exports = express;