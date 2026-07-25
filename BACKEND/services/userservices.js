const jwt = require ('jsonwebtoken');
const userModel = require ('../model/userModel');

class userServis{
    //generate token
    static generateToken(id){
        return jwt.sign({id}, process.env.secret_key,{expiresIn: process.env.secret_key});
    }
    //find user
    static async findUser(email){
        return userModel.findOne(email);
    }
    //save regis
    static async saveUser({username, email, password}){
        return userModel.create({username, email, password});
    }
    //password checker
    static async passwordCheck(email, password){
        var email = await userServis.findUser({email});
        return await email.comparePw(password);
    }
}

module.exports = userServis;


