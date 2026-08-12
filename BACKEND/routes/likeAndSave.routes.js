const likeAndSaveController = require("../controller/likeAndSave.controller");
const express = require("express").Router();
const auth = require("../controller/authController");

express.get("/loadDatas", auth.auth, likeAndSaveController.loadDatas);
express.post("/saveDatas", auth.auth, likeAndSaveController.saveDatas);

module.exports = express;