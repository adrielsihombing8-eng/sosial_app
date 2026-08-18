const componentController = require("../controller/countComponen.controller");
const express = require("express").Router();
const auth = require("../controller/authController");

express.post("/firstDatas", auth.auth, componentController.firstDatas);
express.post("/:postId/loadDatas", auth.auth, componentController.loadDatas);
express.post("/:postId/addView", auth.auth, componentController.addView);
express.post("/:postId/likeToggel", auth.auth, componentController.likeToggel);
express.post("/:postId/saveToggel", auth.auth, componentController.saveToggel);
express.post("/:postId/repostToggel", auth.auth, componentController.repostToggel);

module.exports = express;