const mongoose = require("mongoose");
const userModel = require('../model/userModel');
const { type } = require("node:os");

const countComponenSchema = new mongoose.Schema({
    postId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: contentModel.modelName,
        required: true
    },
    likeCount: {
        type: Number,
        default: 0,
    },
    saveCount: {
        type: Number,
        default: 0,
    },
    repostCount: {
        type: Number,
        default: 0,
    },
    viewCount: {
        type: Number,
        default: 0,
    }
}, { timestamps: true });

module.exports = mongoose.model('countComponen', countComponenSchema);