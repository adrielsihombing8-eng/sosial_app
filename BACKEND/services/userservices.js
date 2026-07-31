const jwt = require ('jsonwebtoken');
const userModel = require ('../model/userModel');
const donevn = require('dotenv');
donevn.config();

class userServis{
    //generate token
    static generateToken(id){
        return jwt.sign({id}, process.env.secret_key,{expiresIn: process.env.secret_key_time});
    }
    //find user
    static async findUser(email){
        return userModel.findOne(email);
    }
    //save regis
    static async saveUser({username, email, password}){
        const user = new userModel({username, email, password})
        return user.save();
    }
    //password checker
    static async passwordCheck(email, password){
        var email = await userServis.findUser({email});
        return await email.comparePw(password);
    }
    //findemail
    static async findUserName(username){
        return userModel.findOne(username);
    }
    //find by id
    static async finUserId(id){
        return userModel.findById(id).select('-password');
    }
    //refresToken
    static generateRefreshToken(id){
        return jwt.sign({id}, process.env.refresh_secret_key,{expiresIn: process.env.refresh_secret_key_time});
    }
}

module.exports = userServis;


