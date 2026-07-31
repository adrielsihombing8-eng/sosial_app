const contentModel = require('../model/contentModel');

class contentServices{
    static async contentAdd(userId, {title, content, imageUrl, date, time}){
        try{
            const content = contentModel({
                userId,
                title,
                content,
                imageUrl,
                date,
                time
            });
            return await content.save();
        }
        catch(err){
            throw new Error("error : ${err.message}");
        }
    }

    static async loadContent(query){
        const content = await contentModel.find(query).sort({ _id: -1 })
            .limit(parseInt(limit));
        return content;
    }
};

module.exports = contentServices;