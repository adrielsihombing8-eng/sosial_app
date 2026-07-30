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
            throw new Error("error to saving data");
        }
    }
};

module.exports = contentServices;