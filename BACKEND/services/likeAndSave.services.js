const likeAndSaveModel = require("../model/likeAndSave.model");

class likeAndSaveServices {
    static async findDatas(userId, objectId) {
        try {
            const datas = await likeAndSaveModel.findOne({ userId: userId, _id: objectId });
            return datas;
        }
        catch (err) {
            throw new Error('error : ${err.message}');
        }
    };

    static async saveDatas(LikesSaveDatas) {
        try {
            const datas = await likeAndSaveModel.create(LikesSaveDatas);
            return datas;
        }
        catch (err) {
            throw new Error('error : ${err.message}');
        }
    };

    static async updateData(objectId, updateData) {
        try{
            const datas = await likeAndSaveModel.findByIdAndUpdate(
                objectId,
                updateData,
                { new: true }
            );
            return datas;
        }
        catch(err){
            throw new Error('Err : ${err.message}');
        }
    };

    static async likeDatas(userId) {
        try {
            const datas = await likeAndSaveModel.find({ userId: userId, like: true }).sort({ _id: -1 });
            return datas;
        }
        catch (err) {
            throw new Error('error : ${err.message}');
        }
    };

    static async saveDatas(userID){
        try{
            const datas = await likeAndSaveModel.find({ userId: userID, save: true }).sort({ _id: -1 });
            return datas;
        }
        catch(err){
            throw new Error('error : ${err.message}');
        }
    };

    static async repostDatas(userID){
        try{
            const datas = await likeAndSaveModel.find({ userId: userID, repost: true }).sort({ _id: -1 });
            return datas;
        }
        catch(err){
            throw new Error('error : ${err.message}');
        }
    };
}

module.exports = likeAndSaveServices;