const contentController = require('../controller/contentController');
const express = require('express').Router();

express.post('/tokenCheck', contentController.middleware);
express.post('/addContent', contentController.middleware, upload.single('image'), contentController.addContent);
express.get('/loadData', contentController.middleware, contentController.loadcontent);
express.get('/findUser', contentController.middleware, contentController.findUser);

module.exports = express;