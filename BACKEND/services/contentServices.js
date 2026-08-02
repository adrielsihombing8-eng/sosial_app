const contentModel = require('../model/contentModel');

class contentServices{
    static async contentAdd(postdata){
        try{
            const content = postdata;
            return await content.save();
        }
        catch(err){
            throw new Error('error : ${err.message}');
        }
    }

    static async loadContent(query){
        const content = await contentModel.find(query).sort({ _id: -1 })
            .limit(parseInt(limit));
        return content;
    }
};

module.exports = contentServices;