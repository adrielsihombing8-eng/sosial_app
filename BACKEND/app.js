const express = require('express');
const cors = require('cors');
const userRoutes = require('./routes/userRoutes');

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({extended : true}));
app.use('/api/auth', userRoutes);
app.use((err, req, res, next) => {
    res.status(500).json({ error: err.message });
});

module.exports = app;
