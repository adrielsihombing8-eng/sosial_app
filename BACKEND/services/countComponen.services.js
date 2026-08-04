const countComponenModel = require("../model/countComponen.model");

class countComponenServices {
    static async saveDatas(datas) {
        try {
            const saveDatas = datas;
            return await saveDatas.save();
        }
        catch (err) {
            throw new Error('error : ${err.message}');
        }
    }
    static async findDatas(userId, objectId) {
        try {
            const datas = await countComponenModel.findOne({ userId: userId });
            return datas;
        }
        catch (err) {
            throw new Error('error : ${err.message}');
        }
    }
    static async updateData(objectId, updateData) {
        try{
            const datas = await countComponenModel.findByIdAndUpdate(
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
}

module.exports = countComponenServices;