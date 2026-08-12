const contentController = require('../controller/contentController');
const multer = require('multer');
const express = require('express').Router();

const upload = multer({ dest: 'uploads/' });

express.post('/tokenCheck', contentController.middleware);
express.post('/addContent', contentController.middleware, upload.single('image'), contentController.addContent);
express.get('/loadData', contentController.middleware, contentController.loadcontent);
express.get('/findUser', contentController.middleware, contentController.findUser);

module.exports = express;