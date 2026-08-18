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
    static async addView(postId , userId) {
        try{
            const result = await countComponenModel.findOneAndUpdate(
                { userId ,postId },
                { $setOnInsert: { userId, postId } },
                { upsert: true, new: true, rawResult: true }
            );

            const isNewView = !result.lastErrorObject.updatedExisting;

            if (isNewView) {
                await countComponenModel.updateOne(
                    { postId },
                    { $inc: { viewCount: 1 }},
                    { upsert: true }
                );
            }

            return isNewView;
        }
        catch (err) {
            throw new Error("error : ${err.message}");
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
    static async saveToggel (userId, postId) {
        const exist = await likeAndSaveModel.findOne({ userId: userId, postId: postId });
        if(exist) {
            exist.save = !exist.save;
            return await exist.save();

            const increment = exist.like ? 1 : -1;
            await countComponenModel.updateOne(
                { postId: postId },
                { $inc: { saveCount: increment } }
            );
            
            return exist;
        }
        else {
            const newSave = new likeAndSaveModel({
                userId: userId,
                postId: postId,
                save: true
            });
            await newLike.save();

            await countComponenModel.updateOne(
                { postId: postId },
                { $inc: { saveCount: 1 } }
            );

            return newSave;
        }
    }
    static async repostToggel (userId, postId) {
        const exist = await likeAndSaveModel.findOne({ userId: userId, postId: postId });
        if(exist) {
            exist.repost = !exist.repost;
            return await exist.save();

            const increment = exist.like ? 1 : -1;
            await countComponenModel.updateOne(
                { postId: postId },
                { $inc: { repostCount: increment } }
            );
            
            return exist;
        }
        else {
            const newRepost = new likeAndSaveModel({
                userId: userId,
                postId: postId,
                repost: true
            });
            await newRepost.save();

            await countComponenModel.updateOne(
                { postId: postId },
                { $inc: { repostCount: 1 } }
            );

            return newRepost;
        }
    }
}

module.exports = countComponenServices;