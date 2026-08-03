const likeAndSaveModel = require("../model/likeAndSave.model");

class likeAndSaveServices{
    static async findDatas(userId){
        try{
            const datas = await likeAndSaveModel.findOne({userId : userId});
            return datas;
        }
        catch(err){
            throw new Error('error : ${err.message}');
        }
    }
    static async saveDatas(LikesSaveDatas){
        try{
            const datas = LikesSaveDatas;
            return await datas.save();
        }
        catch(err){
            throw new Error('error : ${err.message}');
        }
    }
    static async updateData(userId, updateData){
        const datas = await likeAndSaveModel.findOneAndUpdate(
        { userId: userId },
        updateData,
        { new: true }
    );
    return datas;
    }
}

module.exports = likeAndSaveServices;