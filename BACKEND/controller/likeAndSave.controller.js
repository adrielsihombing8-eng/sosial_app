const jwt = require("jsonwebtoken");
const likeAndSaveServices = require("../services/likeAndSave.services");
const likeAndSaveModel = require("../model/likeAndSave.model"); 

//by user view like and save data
exports.loadDatas = async (req, res, next) => {
    const userId = req.userId;
    const {objectId} = req.query;
    
    try{
        const findDatas = await likeAndSaveServices.findDatas(userId, objectId);
        if(!findDatas){
            res.status(400).json({message: "no datas"});
        }

        res.status(200).json({message: "succes to find!!", datas: findDatas});
    }
    catch(err){
        next(err);
    }
};

exports.savingDatas = async (req, res, next) => {
    const userId = req.userId;
    const {postId} = req.params;

    try{
        const likesSave = likeAndSaveModel({
            postId: postId,
            userId: userId,
            like: req.body.like,
            save: req.body.save,
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
};//lebih baik ga dipakai untuk update data, karena bisa menyebabkan lag karena render terus menerus dan memakan storage

//load like data
exports.likeDatas = async (req, res, next) => {
    const userId = req.userId;
    const {objectId} = req.query;

    try{
        const findDatas = await likeAndSaveServices.syncDatas(userId, objectId);
        if(!findDatas){
            res.status(400).json({message: "no datas"});
        }

        res.status(200).json({message: "succes to find!!", datas: findDatas});
    }
    catch(err){
        next(err);
    }
};