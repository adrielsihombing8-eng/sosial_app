const jwt = require("jsonwebtoken");
const likeAndSaveServices = require("../services/likeAndSave.services");
const likeAndSaveModel = require("../model/likeAndSave.model"); 

//by user view
exports.loadDatas = async (req, res, next) => {
    const userId = req.userId;
    const {objectId} = req.query;
    
    try{
        const findDatas = await likeAndSaveServices.findDatas(userId);
        if(!findDatas){
            res.status(400).json({message: "error to find"});
        }

        res.status(200).json({message: "succes to find!!", datas: findDatas});
    }
    catch(err){
        next(err);
    }
};

exports.saveDatas = async (req, res, next) => {
    const userId = req.userId;
    try{
        const likesSave = likeAndSaveModel({
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
};
