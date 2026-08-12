const mongoose = require("mongoose");
const userModel = require('../model/userModel');
const contentModel = require('../model/contentModel');
const { type } = require("node:os");

const likeAndSaveSchema = new mongoose.Schema({
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
    like: {
        type: Boolean,
        require: true,
        default: false
    },
    save: {
        type: Boolean,
        require: true,
        default: false
    },
    repost: {
        type: Boolean,
        require: true,
        default: false
    }
}, { timestamps: true });

module.exports = mongoose.model('likeEndSave', likeAndSaveSchema);