const jwt = require("jsonwebtoken");
const countComponenServices = require("../services/countComponen.services");
const countComponenModel = require("../model/countComponen.model");

exports.loadDatas = async (res, req, next) => {
    const userId = req.userId;
    const {objectId} = req.query;
    
    try{
        const findDatas = await countComponenServices.findDatas(userId, objectId);
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
        const countComponen = countComponenModel({
            userId: userId,
            likeCount: req.body.likeCount,
            saveCount: req.body.saveCount,
            repostCount: req.body.repostCount
        })

        const saving = await countComponenServices.saveDatas(countComponen);
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
    const {objectId} = req.query;
    try{
        const datas = countComponenModel({
            userId: userId,
            likeCount: req.body.likeCount,
            saveCount: req.body.saveCount,
            repostCount: req.body.repostCount
        })

        const updating = await countComponenServices.updateData(objectId, datas);
        res.status(200).json({message : "Succes to updating", datas: updating});
    }
    catch(err){
        next(err);
    }
};