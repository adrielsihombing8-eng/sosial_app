const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const { type } = require('node:os');
const userModel = require('../model/userModel');
const db = require('../config/db');
const { ref } = require('node:process');

const contentSchema = new mongoose.Schema({
    userId: {
        type: Schema.Types.ObjectId,
        ref: userModel.modelName,
        require: true
    },
    title: { type: String, required: true },
    content: String,
    imageUrl: { type: String, default: null },
    date: {
        type: String,
        require: true
    },
    time: {
        type: String,
        require: true
    }
}, { timestamps: true });

module.exports = mongoose.model('content', contentSchema);