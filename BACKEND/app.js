const express = require('express');
const cors = require('cors');
const userRoutes = require('./routes/userRoutes');
const contentRoutes = require('./routes/contentRoutes');
const likeAndSaveRoutes = require('./routes/likeAndSave.routes');

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({extended : true}));
app.use('/api/auth', userRoutes);
app.use('/api/content', contentRoutes);
app.use('/api/likeAndSave', likeAndSaveRoutes);
app.use((err, req, res, next) => {
    res.status(500).json({ error: err.message });
});

module.exports = app;
