const mongoose = require("mongoose");
const userModel = require('../model/userModel');
const { type } = require("node:os");

const countComponenSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: userModel.modelName,
        required: true
    },
    likeCount: {
        type: Number,
        require: true
    },
    saveCount: {
        type: Number,
        require: true
    },
    repostCount: {
        type: Number,
        require: true
    }
}, { timestamps: true });

module.exports = mongoose.model('countComponen', countComponenSchema);