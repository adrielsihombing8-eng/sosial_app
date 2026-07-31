const mongoose = require('mongoose');
const userModel = require('../model/userModel');

const contentSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: userModel.modelName,
        require: true
    },
    title: { type: String, required: true },
    content: String,
    imageUrl: { type: String, default: null },
    createdDate: {
        type: Date,
        required: true
    }
}, { timestamps: true });

module.exports = mongoose.model('content', contentSchema);