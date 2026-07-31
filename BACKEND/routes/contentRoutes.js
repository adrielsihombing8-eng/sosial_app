const contentController = require('../controller/contentController');
const express = require('express').Router();

express.post('/tokenCheck', contentController.middleware);
express.post('/addContent', contentController.middleware, contentController.addContent);
express.get('/loadData', contentController.middleware, contentController.loadcontent);

module.exports = express;