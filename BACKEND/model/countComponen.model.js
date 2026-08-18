const mongoose = require("mongoose");
const userModel = require('../model/userModel');
const contentModel = require('../model/contentModel');
const { type } = require("node:os");

const countComponenSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: userModel.modelName,
        required: true
    },
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

countComponenSchema.index({ userId: 1, postId: 1 }, { unique: true });

module.exports = mongoose.model('countComponen', countComponenSchema);