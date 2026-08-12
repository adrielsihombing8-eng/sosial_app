const jwt = require("jsonwebtoken");
const countComponenServices = require("../services/countComponen.services");
const countComponenModel = require("../model/countComponen.model");
const userservices = require("../services/userservices");

exports.loadDatas = async (req, res, next) => {
    const userId = req.userId;
    const { postId } = req.params;

    try {
        if (!userId) {
            return res.status(400).json({ message: "userId is required" });
        }

        const auth = await userservices.findUserId(userId);
        if (!auth) {
            return res.status(400).json({ message: "userId not found" });
        }
        
        const findDatas = await countComponenServices.findDatas(userId, postId);
        if (!findDatas) {
            res.status(400).json({ message: "error to find" });
        }

        res.status(200).json({ message: "succes to find!!", datas: findDatas });
    }
    catch (err) {
        next(err);
    }
};

exports.firstDatas = async (req, res, next) => {
    const userId = req.userId;
    const { postId } = req.params;

    try {
        if (!userId) {
            return res.status(400).json({ message: "userId is required" });
        }

        const auth = await userservices.findUserId(userId);
        if (!auth) {
            return res.status(400).json({ message: "userId not found" });
        }

        const countComponen = countComponenModel({
            userId: userId,
            postId: postId
        })

        const saving = await countComponenServices.saveDatas(countComponen);
        if (!saving) {
            res.status(400).json({ message: "error save" });
        }

        res.status(200).json({ message: "succes to save!!" });
    }
    catch (err) {
        next(err);
    }
};

exports.addView = async (req, res, next) => {
    const userId = req.userId;
    const { postId } = req.params;

    try {
        if (!userId) {
            return res.status(400).json({ message: "userId is required" });
        }

        const auth = await userservices.findUserId(userId);
        if (!auth) {
            return res.status(400).json({ message: "userId not found" });
        }

        const updateDatas = await countComponenServices.addView(userId, postId);
        if (!updateDatas) {
            res.status(400).json({ message: "error to update" });
        }

        res.status(200).json({ message: "succes to update!!", datas: updateDatas });
    }
    catch (err) {
        next(err);
    }
};

