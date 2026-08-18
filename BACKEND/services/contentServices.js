const contentModel = require('../model/contentModel');
const userModel = require('../model/userModel');

class contentServices{
    static async contentAdd(postdata){
        try{
            const content = postdata;
            return await content.save();
        }
        catch(err){
            throw new Error('error : ${err.message}');
        }
    };

    static async loadContent(query){
        const content = await contentModel.find(query).sort({ _id: -1 })
            .limit(parseInt(limit));
        return content;
    };

    static async getUser(keyword){
        try{
            const user = await userModel.find({ username: { $regex: keyword, $options: 'i' } });
            return user;
        }
        catch(err){
            throw new Error('error : ${err.message}');
        }
    };
};

module.exports = contentServices;