const jwt = require("jsonwebtoken");
const likeAndSaveServices = require("../services/likeAndSave.services");
const likeAndSaveModel = require("../model/likeAndSave.model");

exports.loadDatas = async (res, req, next) => {
    const userId = req.userId;
    try{
        const findDatas = await likeAndSaveServices.findDatas;
        if(!findDatas){
            res.status(400).json({message: "error to find"});
        }

        res.status(200).json({message: "succes to find!!", datas: findDatas});
    }
    catch(err){
        next(err);
    }
};

exports.saveDatas = async (res, req, next) => {
    const userId = req.userId;
    try{
        const likesSave = likeAndSaveModel({
            userId: userId,
            like: req.body.like,
            save: req.body.save,
            firstSee: false,
            repost: req.body.repost
        })

        const saving = await likeAndSaveServices.saveDatas(likesSave);
        if(!saving){
            res.status(400).json({message: "error save"});
        }

        res.status(200).json({message: "succes to save!!"});
    }
    catch(err){
        next(err);
    }
};

exports.updateDatas = async (res, req, next) =>{
    const userId = req.userId;
    try{
        const datas = likeAndSaveModel({
            userId: userId,
            like: req.body.like,
            save: req.body.save,
            firstSee: false,
            repost: req.body.repost
        })

        const updating = await likeAndSaveServices.updateData(userId, datas);
        res.status(200).json({message : "Succes to updating", datas: updating});
    }
    catch(err){}
};