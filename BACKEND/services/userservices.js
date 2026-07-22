const jwt = require ('jsonwebtoken');
const userModel = require ('../model/userModel');

class userServis{
    //generate token
    static async generateToken(id){
        return jwt.sign(id, process.env.secret_key,{expiresIn: process.env.secret_key})
    }
    //find user
    static async findUser(email){
        return userModel.findOne({email});
    }
    //save regis
    static async saveUser(username, email, password){
        return userModel.create({username, email, password});
    }
}

module.exports = userServis;


