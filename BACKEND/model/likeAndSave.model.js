const mongoose = require("mongoose");
const userModel = require('../model/userModel');
const { type } = require("node:os");

const likeAndSaveSchema = new moogose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: userModel.modelName,
        required: true
    },
    like: {
        type: Boolean,
        require: true
    },
    save: {
        type: Boolean,
        require: true
    },
    firstSee: {
        type: Boolean,
        require: true,
    },
    repost: {
        type: Boolean,
        require: true
    }
}, { timestamps: true });

module.exports = moogose.model('likeEndSave', likeAndSaveSchema);