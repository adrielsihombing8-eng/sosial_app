const userController = require('../controller/authController');
const express = require('express').Router();

express.post('/register', userController.register);
express.post('/loginUser', userController.login);

module.exports = express;