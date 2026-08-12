const countComponenModel = require("../model/countComponen.model");
const likeAndSaveModel = require("../model/likeAndSave.model");

class countComponenServices {
    static async saveDatas(datas) {
        try {
            const saveDatas = await countComponenModel.create(datas);
            return saveDatas;
        }
        catch (err) {
            throw new Error('error : ${err.message}');
        }
    }
    static async findDatas(userId, postId) {
        try {
            const datas = await countComponenModel.findOne({ userId: userId, postIdId: postId });
            return datas;
        }
        catch (err) {
            throw new Error('error : ${err.message}');
        }
    }
    static async addView(userId, postId) {
        try{
            const result = await countComponenModel.findOneAndUpdate(
                { postId },
                { $setOnInsert: { postId } },
                { upsert: true, new: true, rawResult: true }
            );

            const isNewView = !result.lastErrorObject.updatedExisting;

            if (isNewView) {
                await countComponenModel.updateOne(
                    { postId },
                    { $inc: { viewCount: 1 } }
                );
            }

            return isNewView;
        }
        catch (err) {
            throw new Error('error : ${err.message}');
        }
    }
    static async likeToggel (userId, postId) {
        const exist = await likeAndSaveModel.findOne({ userId: userId, postId: postId });
        if(exist) {
            exist.like = !exist.like;
            return await exist.save();

            const increment = exist.like ? 1 : -1;
            await countComponenModel.updateOne(
                { postId: postId },
                { $inc: { likeCount: increment } }
            );
            
            return exist;
        }
        else {
            const newLike = new likeAndSaveModel({
                userId: userId,
                postId: postId,
                like: true
            });
            await newLike.save();

            await countComponenModel.updateOne(
                { postId: postId },
                { $inc: { likeCount: 1 } }
            );

            return newLike;
        }
    }
}

module.exports = countComponenServices;