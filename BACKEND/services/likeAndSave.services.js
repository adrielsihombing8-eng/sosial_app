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
    }
    static async saveDatas(LikesSaveDatas) {
        try {
            const datas = await likeAndSaveModel.create(LikesSaveDatas);
            return datas;
        }
        catch (err) {
            throw new Error('error : ${err.message}');
        }
    }
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
    }
    static async syncDatas(userId, objectId) {
        try {
            const datas = await likeAndSaveModel.findOne({ _id: objectId, userId: userId });
            return datas;
        }
        catch (err) {}
    }
}

module.exports = likeAndSaveServices;