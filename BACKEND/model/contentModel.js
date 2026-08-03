const mongoose = require('mongoose');
const userModel = require('../model/userModel');
const { type } = require('node:os');

const contentSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: userModel.modelName,
        required: true
    },
    title: { type: String, required: true },
    content: String,
    imageUrl: { type: String, default: null },
    imagePublicId: { type: String, default: null },
}, { timestamps: true });

module.exports = mongoose.model('content', contentSchema);